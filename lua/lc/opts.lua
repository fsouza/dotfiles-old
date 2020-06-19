local M = {}

local lsp = require('nvim_lsp')
local helpers = require('lib/nvim_helpers')

local attached = function(bufnr, enable_autoformat)
  vim.schedule(function()
    local mappings = {
      n = {
        {
          lhs = '<localleader>gd';
          rhs = helpers.cmd_map('lua vim.lsp.buf.definition()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>gy';
          rhs = helpers.cmd_map('lua vim.lsp.buf.declaration()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>gi';
          rhs = helpers.cmd_map('lua vim.lsp.buf.implementation()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>r';
          rhs = helpers.cmd_map('lua vim.lsp.buf.rename()');
          opts = {silent = true}
        };
        {
          lhs = '<localleader>i';
          rhs = helpers.cmd_map('lua vim.lsp.buf.hover()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>s';
          rhs = helpers.cmd_map('lua vim.lsp.buf.document_highlight()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>T';
          rhs = helpers.cmd_map('lua vim.lsp.buf.workspace_symbol()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>t';
          rhs = helpers.cmd_map('lua vim.lsp.buf.document_symbol()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>q';
          rhs = helpers.cmd_map('lua vim.lsp.buf.references()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>cc';
          rhs = helpers.cmd_map('lua vim.lsp.buf.code_action()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>d';
          rhs = helpers.cmd_map('lua require("lc/fn").show_line_diagnostics()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>ld';
          rhs = helpers.cmd_map('lua require("lc/fn").list_file_diagnostics()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>cl';
          rhs = helpers.cmd_map('lua vim.lsp.util.buf_clear_diagnostics()');
          opts = {silent = true}
        }; {
          lhs = '<localleader>f';
          rhs = helpers.cmd_map('lua vim.lsp.buf.formatting()');
          opts = {silent = true}
        };
        {
          lhs = '<c-k>';
          rhs = helpers.cmd_map('lua vim.lsp.buf.signature_help()');
          opts = {silent = true}
        }
      };
      i = {
        {
          lhs = '<c-k>';
          rhs = helpers.cmd_map('lua vim.lsp.buf.signature_help()');
          opts = {silent = true}
        }
      }
    }
    helpers.create_mappings(mappings, bufnr)

    if enable_autoformat then
      vim.api.nvim_command([[autocmd BufWritePre <buffer> lua require('lc/fn').auto_format()]])
    end
  end)
end

function on_attach(client, bufnr)
  local all_clients = vim.lsp.get_active_clients()
  for _, c in pairs(all_clients) do
    if c.name == client.name then
      client = c
    end
  end

  local enable_autoformat = client.resolved_capabilities.document_formatting
  attached(bufnr, enable_autoformat)
end

function M.with_default_opts(opts)
  opts.callbacks = require('lc/callbacks')
  opts.on_attach = on_attach
  return opts
end

M.project_root_pattern = lsp.util.root_pattern('.git', 'requirements.txt')

return M
