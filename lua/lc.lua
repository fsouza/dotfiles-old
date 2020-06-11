local M = {}

local callbacks = require('lc_callbacks')

function M.setup()
  pcall(function ()
    local function on_attach(client, _)
      local all_clients = vim.lsp.get_active_clients()
      for _, c in pairs(all_clients) do
        if c.name == client.name then
          client = c
        end
      end

      local enable_autoformat = client.resolved_capabilities.document_formatting
      vim.api.nvim_call_function('fsouza#lc#LC_attached', { enable_autoformat })
    end

    local lsp = require('nvim_lsp')

    lsp.bashls.setup({
      cmd = { 'vim-nodels', 'bash-language-server', 'start' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.cssls.setup({
      cmd = { 'vim-nodels', 'css-laguageserver', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.gopls.setup({
      init_options = {
        deepCompletion = false;
        staticcheck = true;
        analyses = {
          unusedparams = true;
          ST1000 = false;
        };
      };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.html.setup({
      cmd = { 'vim-nodels', 'html-langserver', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.jsonls.setup({
      cmd = { 'vim-nodels', 'vscode-json-languageserver', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.ocamllsp.setup({
      cmd = { 'vim-ocaml-lsp' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.pyls.setup({
      cmd = { 'python', '-m', 'pyls' };
      settings = {
        pyls = {
          plugins = {
            jedi_completion = {
              enabled = true;
              fuzzy = true;
              include_params = false;
            };
          };
        };
      };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.rust_analyzer.setup({
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.tsserver.setup({
      cmd = { 'vim-nodels', 'typescript-language-server', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.vimls.setup({
      cmd = { 'vim-nodels',  'vim-language-server', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })

    lsp.yamlls.setup({
      cmd = { 'vim-nodels', 'yaml-language-server', '--stdio' };
      on_attach = on_attach;
      callbacks = callbacks;
    })
  end)
end

-- TODO: nvim-lsp will eventually support this, so once the pending PR is
-- merged, we should delete this code.
local function formatting_params(options)
  local sts = vim.bo.softtabstop
  options = vim.tbl_extend('keep', options or {}, {
    tabSize = (sts > 0 and sts) or (sts < 0 and vim.bo.shiftwidth) or vim.bo.tabstop;
    insertSpaces = vim.bo.expandtab;
  })
  return {
    textDocument = { uri = vim.uri_from_bufnr(0) };
    options = options;
  }
end

function M.formatting_sync(options, timeout_ms)
  local params = formatting_params(options)
  local result = vim.lsp.buf_request_sync(0, 'textDocument/formatting', params, timeout_ms)
  if not result then return end
  if not result[1] then return end
  result = result[1].result
  vim.lsp.util.apply_text_edits(result)
end

return M
