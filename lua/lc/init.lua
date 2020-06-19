return function()
  local get_local_cmd = function(cmd)
    return string.format('%s/%s/%s', vim.fn.stdpath('config'), 'lsp-bin', cmd)
  end

  local status, err = pcall(function()
    local lsp = require('nvim_lsp')
    local vim_node_ls = get_local_cmd('node-lsp')
    local lc_opts = require('lc/opts')

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
        local ancestor = opts.project_root_pattern(fname)
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

    lsp.pyls_ms.setup(lc_opts.with_default_opts({
      cmd = {get_local_cmd('ms-python-lsp')};
      root_dir = opts.project_root_pattern
    }))

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

  if vim.loop.os_getenv('NVIM_DEBUG') and not status then
    print('failed to setup lc: ' .. err)
  end
end
