local M = {}

local vfn = vim.fn
local lsp = require('nvim_lsp')
local helpers = require('lib.nvim_helpers')

local lsp_highlight = function(mappings)
  table.insert(mappings.n, {
    lhs = '<localleader>s';
    rhs = helpers.cmd_map('lua vim.lsp.buf.document_highlight()');
    opts = {silent = true};
  })
  table.insert(mappings.n, {
    lhs = '<localleader>S';
    rhs = helpers.cmd_map('lua vim.lsp.buf.clear_references()');
    opts = {silent = true};
  })
end

local ts_highlight = function(mappings)
  table.insert(mappings.n, {
    lhs = '<localleader>s';
    rhs = helpers.cmd_map('lua require("nvim-treesitter.refactor.highlight_definitions").highlight_usages()');
    opts = {silent = true};
  })
  table.insert(mappings.n, {
    lhs = '<localleader>S';
    rhs = helpers.cmd_map('lua require("nvim-treesitter.refactor.highlight_definitions").clear_usage_highlights()');
    opts = {silent = true};
  })
end

local ts_supported = function()
  local parsers = require('nvim-treesitter.parsers')
  return parsers.has_parser()
end

local attached = function(bufnr, client)
  vim.schedule(function()
    vim.g.vista_default_executive = 'nvim_lsp'
    local mappings = {
      n = {
        {
          lhs = '<localleader>r';
          rhs = helpers.cmd_map('lua vim.lsp.buf.rename()');
          opts = {silent = true};
        }; {
          lhs = '<localleader>d';
          rhs = helpers.cmd_map('lua require("lc.diagnostics").show_line_diagnostics()');
          opts = {silent = true};
        }; {
          lhs = '<localleader>ld';
          rhs = helpers.cmd_map('lua require("lc.diagnostics").list_file_diagnostics()');
          opts = {silent = true};
        }; {
          lhs = '<localleader>cl';
          rhs = helpers.cmd_map('lua vim.lsp.util.buf_clear_diagnostics(0)');
          opts = {silent = true};
        }; {lhs = '<localleader>v'; rhs = helpers.cmd_map('Vista!!'); opts = {silent = true}};
      };
      i = {};
    }

    if client.resolved_capabilities.code_action then
      table.insert(mappings.n, {
        lhs = '<localleader>cc';
        rhs = helpers.cmd_map('lua vim.lsp.buf.code_action()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.declaration then
      table.insert(mappings.n, {
        lhs = '<localleader>gy';
        rhs = helpers.cmd_map('lua vim.lsp.buf.declaration()');
        opts = {silent = true};
      })
      table.insert(mappings.n, {
        lhs = '<localleader>py';
        rhs = helpers.cmd_map('lua require("lc.locations").preview_declaration()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.document_formatting then
      require('lc.formatting').register_client(client, bufnr)
    end

    if client.resolved_capabilities.document_highlight then
      if ts_supported() then
        ts_highlight(mappings)
      else
        lsp_highlight(mappings)
      end
    end

    if client.resolved_capabilities.document_symbol then
      table.insert(mappings.n, {
        lhs = '<localleader>t';
        rhs = helpers.cmd_map('lua vim.lsp.buf.document_symbol()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.find_references then
      table.insert(mappings.n, {
        lhs = '<localleader>q';
        rhs = helpers.cmd_map('lua vim.lsp.buf.references()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.goto_definition then
      table.insert(mappings.n, {
        lhs = '<localleader>gd';
        rhs = helpers.cmd_map('lua vim.lsp.buf.definition()');
        opts = {silent = true};
      })
      table.insert(mappings.n, {
        lhs = '<localleader>pd';
        rhs = helpers.cmd_map('lua require("lc.locations").preview_definition()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.hover then
      table.insert(mappings.n, {
        lhs = '<localleader>i';
        rhs = helpers.cmd_map('lua vim.lsp.buf.hover()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.implementation then
      table.insert(mappings.n, {
        lhs = '<localleader>gi';
        rhs = helpers.cmd_map('lua vim.lsp.buf.implementation()');
        opts = {silent = true};
      })
      table.insert(mappings.n, {
        lhs = '<localleader>pi';
        rhs = helpers.cmd_map('lua require("lc.locations").preview_implementation()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.signature_help then
      table.insert(mappings.n, {
        lhs = '<c-k>';
        rhs = helpers.cmd_map('lua vim.lsp.buf.signature_help()');
        opts = {silent = true};
      })
      table.insert(mappings.i, {
        lhs = '<c-k>';
        rhs = helpers.cmd_map('lua vim.lsp.buf.signature_help()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.type_definition then
      table.insert(mappings.n, {
        lhs = '<localleader>gt';
        rhs = helpers.cmd_map('lua vim.lsp.buf.type_definition()');
        opts = {silent = true};
      })
      table.insert(mappings.n, {
        lhs = '<localleader>pt';
        rhs = helpers.cmd_map('lua require("lc.locations").preview_type_definition()');
        opts = {silent = true};
      })
    end

    if client.resolved_capabilities.workspace_symbol then
      table.insert(mappings.n, {
        lhs = '<localleader>T';
        rhs = helpers.cmd_map('lua vim.lsp.buf.workspace_symbol()');
        opts = {silent = true};
      })
    end

    vim.schedule(function()
      helpers.create_mappings(mappings, bufnr)
    end)
  end)
end

local on_attach = function(client, bufnr)
  require('completion').on_attach(client)

  local all_clients = vim.lsp.get_active_clients()
  for _, c in pairs(all_clients) do
    if c.name == client.name then
      client = c
    end
  end

  attached(bufnr, client)
end

function M.with_default_opts(opts)
  return vim.tbl_extend('keep', opts, {callbacks = require('lc.callbacks'); on_attach = on_attach})
end

M.project_root_pattern = lsp.util.root_pattern('.git')

M.cwd_root_pattern = function()
  return vfn.getcwd()
end

return M
