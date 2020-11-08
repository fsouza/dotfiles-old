local vcmd = vim.cmd
local vfn = vim.fn
local lc_opts = require('lc.opts')

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

local disable_unsupported_method = function()
  vim.lsp._unsupported_methood = function()
  end
end

local setup_hl = function()
  vcmd([[
highlight LspDiagnosticsVirtualTextError guifg=#afafaf
highlight LspDiagnosticsVirtualTextError guifg=#262626
highlight link LspDiagnosticsSignError SignColumn
highlight LspDiagnosticsVirtualTextWarning guifg=#afafaf
highlight LspDiagnosticsVirtualTextWarning guifg=#262626
highlight link LspDiagnosticsSignWarning SignColumn
highlight LspDiagnosticsVirtualTextInformation guifg=#afafaf
highlight LspDiagnosticsVirtualTextInformation guifg=#262626
highlight link LspDiagnosticsSignInformation SignColumn
highlight LspDiagnosticsVirtualTextHint guifg=#afafaf
highlight LspDiagnosticsVirtualTextHint guifg=#262626
highlight link LspDiagnosticsSignHint SignColumn
]])
end

do
  vim.schedule(setup_hl)
  disable_unsupported_method()

  local if_executable = function(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  set_log_level()
  vcmd([[packadd nvim-lspconfig]])
  local lsp = require('nvim_lsp')
  local vim_node_ls = get_local_cmd('node-lsp')

  if_executable('npx', function()
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

    local init_options, filetypes = require('lc.diagnosticls').gen_config()
    lsp.diagnosticls.setup(lc_opts.with_default_opts(
                             {
        cmd = {vim_node_ls; 'diagnostic-languageserver'; '--stdio'; '--log-level'; '4'};
        filetypes = filetypes;
        init_options = init_options;
      }))

    require('lc.custom.pyright').setup(lc_opts.with_default_opts(
                                         {
        cmd = {vim_node_ls; 'pyright-langserver'; '--stdio'};
        root_dir = lc_opts.cwd_root_pattern;
      }))
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
    require('lc.custom.golangcilint').setup(lc_opts.with_default_opts({}))
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
    lsp.rust_analyzer.setup(lc_opts.with_default_opts({}))
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

  local clangd = os.getenv('HOMEBREW_PREFIX') .. '/opt/llvm/bin/clangd'
  if_executable(clangd, function()
    lsp.clangd.setup(lc_opts.with_default_opts({
      cmd = {clangd; '--background-index'; '--pch-storage=memory'};
    }))
  end)
end
