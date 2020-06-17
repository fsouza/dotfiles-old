local M = {}

local helpers = require('nvim_helpers')

function M.attached(bufnr, enable_autoformat)
  vim.schedule(function()
    local mappings = {
      n = {
        ['<localleader>gd'] = {
          helpers.cmd_map('lua vim.lsp.buf.definition()');
          silent = true
        };
        ['<localleader>gy'] = {
          helpers.cmd_map('lua vim.lsp.buf.declaration()');
          silent = true
        };
        ['<localleader>gi'] = {
          helpers.cmd_map('lua vim.lsp.buf.implementation()');
          silent = true
        };
        ['<localleader>r'] = {helpers.cmd_map('lua vim.lsp.buf.rename()'); silent = true};
        ['<localleader>i'] = {helpers.cmd_map('lua vim.lsp.buf.hover()'); silent = true};
        ['<localleader>s'] = {
          helpers.cmd_map('lua vim.lsp.buf.document_highlight()');
          silent = true
        };
        ['<localleader>T'] = {
          helpers.cmd_map('lua vim.lsp.buf.workspace_symbol()');
          silent = true
        };
        ['<localleader>t'] = {
          helpers.cmd_map('lua vim.lsp.buf.document_symbol()');
          silent = true
        };
        ['<localleader>q'] = {
          helpers.cmd_map('lua vim.lsp.buf.references()');
          silent = true
        };
        ['<localleader>cc'] = {
          helpers.cmd_map('lua vim.lsp.buf.code_action()');
          silent = true
        };
        ['<localleader>d'] = {
          helpers.cmd_map('lua require("lc").show_line_diagnostics()');
          silent = true
        };
        ['<localleader>cl'] = {
          helpers.cmd_map('lua vim.lsp.util.buf_clear_diagnostics()');
          silent = true
        };
        ['<localleader>f'] = {
          helpers.cmd_map('lua vim.lsp.buf.formatting()');
          silent = true
        };
        ['<c-k>'] = {helpers.cmd_map('lua vim.lsp.buf.signature_help()'); silent = true}
      };
      i = {
        ['<c-k>'] = {helpers.cmd_map('lua vim.lsp.buf.signature_help()'); {silent = true}}
      }
    }
    helpers.create_mappings(mappings, bufnr)

    if enable_autoformat then
      vim.api.nvim_command(
        [[autocmd BufWritePre <buffer> lua require('lc').auto_format()]])
    end
  end)
end

return M
