local vcmd = vim.cmd
local vfn = vim.fn
local loop = vim.loop
local lc_opts = require('lc.opts')

local config_dir = vfn.stdpath('config')

local get_local_cmd = function(cmd)
  return string.format('%s/langservers/bin/%s', config_dir, cmd)
end

local set_log_level = function()
  local level = 'ERROR'
  if loop.os_getenv('NVIM_DEBUG') then
    level = 'TRACE'
  end
  require('vim.lsp.log').set_level(level)
end

do
  local langservers_bin_path = vfn.stdpath('cache') .. '/langservers/bin'
  vcmd(string.format([[let $PATH = '%s:'.$PATH]], langservers_bin_path))

  local if_executable = function(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  set_log_level()
  local lsp = require('nvim_lsp')
  local vim_node_ls = get_local_cmd('node-lsp')

  if_executable('npx', function()
    lsp.bashls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'bash-language-server'; 'start'};
    }))

    lsp.cssls.setup(
      lc_opts.with_default_opts({cmd = {vim_node_ls; 'css-laguageserver'; '--stdio'}}))

    lsp.html.setup(lc_opts.with_default_opts({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

    lsp.jsonls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
    }))

    lsp.tsserver.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'};
      filetypes = {'javascript'; 'typescript'; 'typescriptreact'; 'typescript.tsx'};
    }))

    lsp.vimls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vim-language-server'; '--stdio'};
    }))

    lsp.yamlls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'};
    }))

    local init_options, filetypes = require('lc.diagnosticls').gen_config()
    lsp.diagnosticls.setup(lc_opts.with_default_opts(
                             {
        cmd = {vim_node_ls; 'diagnostic-languageserver'; '--stdio'};
        filetypes = filetypes;
        init_options = init_options;
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

  if_executable('dune', function()
    lsp.ocamllsp.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('ocaml-lsp')}}))
  end)

  if_executable('jedi-language-server', function()
    lsp.jedi_language_server.setup(lc_opts.with_default_opts(
                                     {{init_options = {completion = {disableSnippets = true}}}}))
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
                'vim'; 'describe'; 'it'; 'before_each'; 'after_each'; 'teardown'; 'pending';
              };
            };
          };
        };
      }))
  end)

  local clangd = loop.os_getenv('HOMEBREW_PREFIX') .. '/opt/llvm/bin/clangd'
  if_executable(clangd, function()
    lsp.clangd.setup(lc_opts.with_default_opts({
      cmd = {clangd; '--background-index'; '--pch-storage=memory'};
    }))
  end)
end
