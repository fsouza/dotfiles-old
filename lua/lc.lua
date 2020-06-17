local M = {}

local callbacks = require('lc_callbacks')

local get_local_cmd = function(cmd)
  return string.format('%s/%s/%s', vim.fn.stdpath('config'), 'lsp-bin', cmd)
end

function M.setup()
  local status, err = pcall(function()
    local function on_attach(client, _)
      local all_clients = vim.lsp.get_active_clients()
      for _, c in pairs(all_clients) do if c.name == client.name then client = c end end

      local enable_autoformat = client.resolved_capabilities.document_formatting
      vim.api.nvim_call_function('fsouza#lc#LC_attached', {enable_autoformat})
    end

    local lsp = require('nvim_lsp')
    local vim_node_ls = get_local_cmd('node-lsp')

    lsp.bashls.setup({
      cmd = {vim_node_ls; 'bash-language-server'; 'start'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.cssls.setup({
      cmd = {vim_node_ls; 'css-laguageserver'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.gopls.setup({
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {unusedparams = true; ST1000 = false}
      };
      capabilities = {
        textDocument = {completion = {completionItem = {snippetSupport = false}}}
      };
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.html.setup({
      cmd = {vim_node_ls; 'html-langserver'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.jsonls.setup({
      cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.ocamllsp.setup({
      cmd = {get_local_cmd('ocaml-lsp')};
      on_attach = on_attach;
      callbacks = callbacks
    })

    local pyls_root_pattern = lsp.util.root_pattern('.git', 'requirements.txt')
    lsp.pyls.setup({
      cmd = {'python'; '-m'; 'pyls'};
      root_dir = function(fname)
        local ancestor = pyls_root_pattern(fname)
        if not ancestor then return lsp.util.path.dirname(fname) end
        return ancestor
      end;
      settings = {
        pyls = {
          enable = true;
          plugins = {
            jedi_completion = {enabled = true; fuzzy = true; include_params = false}
          }
        }
      };
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.rust_analyzer.setup({
      cmd = {get_local_cmd('rust-analyzer')};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.tsserver.setup({
      cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.vimls.setup({
      cmd = {vim_node_ls; 'vim-language-server'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })

    lsp.yamlls.setup({
      cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'};
      on_attach = on_attach;
      callbacks = callbacks
    })
  end)

  if vim.loop.os_getenv('NVIM_DEBUG') and not status then
    print('failed to setup lc: ' .. err)
  end
end

-- TODO: nvim-lsp will eventually support this, so once the pending PR is
-- merged, we should delete this code.
local function formatting_params(options)
  local sts = vim.bo.softtabstop
  options = vim.tbl_extend('keep', options or {}, {
    tabSize = (sts > 0 and sts) or (sts < 0 and vim.bo.shiftwidth) or vim.bo.tabstop;
    insertSpaces = vim.bo.expandtab
  })
  return {textDocument = {uri = vim.uri_from_bufnr(0)}; options = options}
end

function M.formatting_sync(options, timeout_ms)
  local params = formatting_params(options)
  local result = vim.lsp
                   .buf_request_sync(0, 'textDocument/formatting', params, timeout_ms)
  if not result then return end
  if not result[1] then return end
  result = result[1].result
  vim.lsp.util.apply_text_edits(result)
end

function M.show_line_diagnostics()
  local prefix = '- '
  local indent = '  '
  local lines = {'Diagnostics:'; ''}
  local line_diagnostics = vim.lsp.util.get_line_diagnostics()
  if vim.tbl_isempty(line_diagnostics) then return end

  for _, diagnostic in pairs(line_diagnostics) do
    local message_lines = vim.split(diagnostic.message, '\n', true)
    table.insert(lines, prefix .. message_lines[1])
    for j = 2, #message_lines do table.insert(lines, indent .. message_lines[j]) end
  end
  return vim.lsp.util.open_floating_preview(lines, 'plaintext')
end

return M
