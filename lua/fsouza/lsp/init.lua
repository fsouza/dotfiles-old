local vcmd = vim.cmd
local vfn = vim.fn

local config_dir = vfn.stdpath('config')

local get_local_cmd = function(cmd)
  return string.format('%s/langservers/bin/%s', config_dir, cmd)
end

local set_log_level = function()
  local level = 'ERROR'
  if os.getenv('NVIM_DEBUG') then
    level = 'TRACE'
  end
  require('vim.lsp.log').set_level(level)
end

-- override some stuff in vim.lsp
local patch_lsp = function()
  -- disable unsupported method so I don't get random errors.
  vim.lsp._unsupported_methood = function()
  end

  -- override show_line_diagnostics so I can get the proper theme in the popup
  -- window.
  local original_show_line_diagnostics = vim.lsp.diagnostic.show_line_diagnostics
  vim.lsp.diagnostic.show_line_diagnostics = function(opts)
    local bufnr, winid = original_show_line_diagnostics(opts)
    require('fsouza.color').set_popup_winid(winid)
    return bufnr, winid
  end
end

local setup_hl = function()
  vcmd([[
highlight LspDiagnosticsFloatingError guifg=#262626
highlight LspDiagnosticsFloatingWarning guifg=#262626
highlight LspDiagnosticsFloatingInformation guifg=#262626
highlight LspDiagnosticsFloatingHint guifg=#262626

highlight link LspDiagnosticsSignError SignColumn
highlight link LspDiagnosticsSignWarning SignColumn
highlight link LspDiagnosticsSignInformation SignColumn
highlight link LspDiagnosticsSignHint SignColumn
]])
end

do
  vim.schedule(setup_hl)
  patch_lsp()

  local if_executable = function(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  set_log_level()
  vcmd([[packadd nvim-lspconfig]])
  local lsp = require('lspconfig')
  local lc_opts = require('fsouza.lsp.opts')

  if_executable('npx', function()
    local vim_node_ls = get_local_cmd('node-lsp')
    lsp.bashls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'bash-language-server'; 'start'};
    }))

    lsp.cssls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'css-languageserver'; '--stdio'};
    }))

    lsp.html.setup(lc_opts.with_default_opts({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

    lsp.jsonls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
    }))

    lsp.tsserver.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'};
      filetypes = {'javascript'; 'typescript'; 'typescriptreact'; 'typescript.tsx'};
    }))

    lsp.yamlls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'};
    }))

    local init_options, filetypes = require('fsouza.lsp.diagnosticls').gen_config()
    lsp.diagnosticls.setup(lc_opts.with_default_opts(
                             {
        cmd = {vim_node_ls; 'diagnostic-languageserver'; '--stdio'; '--log-level'; '4'};
        filetypes = filetypes;
        init_options = init_options;
      }))

    lsp.pyright.setup(lc_opts.with_default_opts(require('fsouza.lsp.custom.pyright').get_opts(
                                                  {
        cmd = {vim_node_ls; 'pyright-langserver'; '--stdio'};
      })))
  end)

  if_executable('gopls', function()
    lsp.gopls.setup(lc_opts.with_default_opts({
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {unusedparams = true; ST1000 = false};
      };
    }))
  end)

  if_executable('golangci-lint-langserver', function()
    require('fsouza.lsp.custom.golangcilint').setup(lc_opts.with_default_opts({}))
  end)

  if_executable('dune', function()
    lsp.ocamllsp.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('ocaml-lsp')}}))
  end)

  if_executable('mix', function()
    lsp.elixirls.setup(lc_opts.with_default_opts({
      cmd = {vfn.stdpath('cache') .. '/langservers/elixir-ls/release/language_server.sh'};
    }))
  end)

  if_executable('rust-analyzer', function()
    lsp.rust_analyzer.setup(lc_opts.with_default_opts({settings = {}}))
  end)

  if_executable('ninja', function()
    lsp.sumneko_lua.setup(lc_opts.with_default_opts(
                            {
        cmd = {get_local_cmd('lua-lsp')};
        settings = {
          Lua = {
            runtime = {version = 'LuaJIT'};
            diagnostics = {
              enable = true;
              globals = {
                'vim';
                'insulate';
                'describe';
                'it';
                'before_each';
                'after_each';
                'teardown';
                'pending';
              };
            };
          };
        };
      }))
  end)

  if_executable('zig', function()
    require('fsouza.lsp.custom.zls').setup(lc_opts.with_default_opts(
                                             {cmd = {get_local_cmd('zig-lsp')}}))
  end)

  local clangd = os.getenv('HOMEBREW_PREFIX') .. '/opt/llvm/bin/clangd'
  if_executable(clangd, function()
    lsp.clangd.setup(lc_opts.with_default_opts({
      cmd = {clangd; '--background-index'; '--pch-storage=memory'};
    }))
  end)
end
