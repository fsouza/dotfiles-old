local vcmd = vim.cmd
local vfn = vim.fn

local config_dir = vfn.stdpath('config')

local function get_local_cmd(cmd)
  return string.format('%s/langservers/bin/%s', config_dir, cmd)
end

local function set_log_level()
  local level = 'ERROR'
  if os.getenv('NVIM_DEBUG') then
    level = 'TRACE'
  end
  require('vim.lsp.log').set_level(level)
end

-- override some stuff in vim.lsp
local function patch_lsp()
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

  -- override the virtualtext to include source.
  vim.lsp.diagnostic.get_virtual_text_chunks_for_line =
    function(_, _, line_diags)
      if #line_diags == 0 then
        return nil
      end
      local virt_texts = {{'    '}}
      local last = line_diags[#line_diags]
      local prefix = '～'
      if last.message then
        table.insert(virt_texts, {
          string.format('%s [%s] %s', prefix, last.source,
                        last.message:gsub('\r', ''):gsub('\n', '  '));
          'LspDiagnosticsVirtualText';
        })
        return virt_texts
      end
    end
end

do
  patch_lsp()

  local function if_executable(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  set_log_level()
  vcmd([[packadd nvim-lspconfig]])
  local lsp = require('lspconfig')
  local opts = require('fsouza.lsp.opts')

  if_executable('npx', function()
    local vim_node_ls = get_local_cmd('node-lsp')
    lsp.bashls.setup(opts.with_defaults({cmd = {vim_node_ls; 'bash-language-server'; 'start'}}))

    lsp.cssls.setup(opts.with_defaults({cmd = {vim_node_ls; 'css-languageserver'; '--stdio'}}))

    lsp.html.setup(opts.with_defaults({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

    lsp.jsonls.setup(opts.with_defaults({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
    }))

    lsp.tsserver.setup(opts.with_defaults({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'};
      filetypes = {'javascript'; 'typescript'; 'typescriptreact'; 'typescript.tsx'};
    }))

    lsp.yamlls.setup(opts.with_defaults({cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'}}))

    lsp.pyright.setup(opts.with_defaults(require('fsouza.lsp.custom.pyright').get_opts(
                                           {cmd = {vim_node_ls; 'pyright-langserver'; '--stdio'}})))
  end)

  if_executable('gopls', function()
    lsp.gopls.setup(opts.with_defaults({
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {
          fillreturns = true;
          nonewvars = true;
          undeclaredname = true;
          unusedparams = true;
          ST1000 = false;
        };
        linksInHover = false;
      };
    }))
  end)

  if_executable('efm-langserver', function()
    local settings, filetypes = require('fsouza.lsp.efm').gen_config()
    lsp.efm.setup(opts.with_defaults({
      init_options = {documentFormatting = true};
      settings = settings;
      filetypes = filetypes;
    }))
  end)

  if_executable('golangci-lint-langserver', function()
    require('fsouza.lsp.custom.golangcilint').setup(opts.with_defaults({}))
  end)

  if_executable('opam', function()
    lsp.ocamllsp.setup(opts.with_defaults({cmd = {get_local_cmd('ocaml-lsp')}}))
  end)

  if_executable('rust-analyzer', function()
    lsp.rust_analyzer.setup(opts.with_defaults({settings = {}}))
  end)

  if_executable('ninja', function()
    lsp.sumneko_lua.setup(opts.with_defaults({
      cmd = {get_local_cmd('lua-lsp')};
      settings = {
        Lua = {
          runtime = {path = vim.split(package.path, ';'); version = 'LuaJIT'};
          diagnostics = {enable = true; globals = {'vim'}};
          workspace = {
            library = {[vfn.expand('$VIMRUNTIME/lua')] = true; [config_dir .. '/lua'] = true};
          };
        };
      };
    }))
  end)

  local clangd = os.getenv('HOMEBREW_PREFIX') .. '/opt/llvm/bin/clangd'
  if_executable(clangd, function()
    lsp.clangd.setup(opts.with_defaults({
      cmd = {clangd; '--background-index'; '--pch-storage=memory'};
    }))
  end)
end
