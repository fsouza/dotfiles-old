return function()
  local loop = vim.loop
  local lc_opts = require('lc/opts')

  local get_local_cmd = function(cmd)
    return string.format('%s/%s/%s', vim.fn.stdpath('config'), 'lsp-bin', cmd)
  end

  local get_pyls_ms_options = function()
    local opts = {cmd = {get_local_cmd('ms-python-lsp')}; root_dir = lc_opts.project_root_pattern}
    local virtual_env = loop.os_getenv('VIRTUAL_ENV')
    if virtual_env then
      local props = require('lc/helpers').interpreter_properties_from_virtualenv(virtual_env)
      if props.Version then
        opts.init_options = {interpreter = {properties = props}}
      end
    end
    return opts
  end

  local status, err = pcall(function()
    local lsp = require('nvim_lsp')
    local vim_node_ls = get_local_cmd('node-lsp')

    lsp.bashls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'bash-language-server'; 'start'}
    }))

    lsp.cssls.setup(
      lc_opts.with_default_opts({cmd = {vim_node_ls; 'css-laguageserver'; '--stdio'}}))

    lsp.gopls.setup(lc_opts.with_default_opts({
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {unusedparams = true; ST1000 = false}
      };
      capabilities = {textDocument = {completion = {completionItem = {snippetSupport = false}}}}
    }))

    lsp.html.setup(lc_opts.with_default_opts({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

    lsp.jsonls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'}
    }))

    lsp.ocamllsp.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('ocaml-lsp')}}))

    lsp.pyls.setup(lc_opts.with_default_opts({
      cmd = {'python'; '-m'; 'pyls'};
      root_dir = function(fname)
        local ancestor = lc_opts.project_root_pattern(fname)
        if not ancestor then
          return vim.fn.getcwd()
        end
        return ancestor
      end;
      settings = {
        pyls = {
          enable = true;
          plugins = {
            jedi_completion = {enabled = false};
            jedi_hover = {enabled = false};
            jedi_references = {enabled = false};
            jedi_signature_help = {enabled = false};
            jedi_symbols = {enabled = false}
          }
        }
      }
    }))

    lsp.pyls_ms.setup(lc_opts.with_default_opts(get_pyls_ms_options()))

    lsp.rust_analyzer.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('rust-analyzer')}}))

    lsp.tsserver.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'}
    }))

    lsp.vimls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'vim-language-server'; '--stdio'}
    }))

    lsp.yamlls.setup(lc_opts.with_default_opts({
      cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'}
    }))
  end)

  if loop.os_getenv('NVIM_DEBUG') and not status then
    print('failed to setup lc: ' .. err)
  end
end
