local M = {}

local api = vim.api
local lsp = vim.lsp
local vcmd = vim.cmd
local helpers = require('fsouza.lib.nvim_helpers')

local n_diagnostics_by_bufnr = {}

local function items_from_diagnostics(bufnr, diagnostics)
  local fname = api.nvim_buf_get_name(bufnr)
  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local pos = diagnostic.range.start
    table.insert(items, {
      filename = fname;
      lnum = pos.line + 1;
      col = pos.character + 1;
      text = diagnostic.message;
    })
  end
  return items
end

local function render_diagnostics(items)
  lsp.util.set_qflist(items)
  if vim.tbl_isempty(items) then
    vcmd('cclose')
  else
    vcmd('copen')
    vcmd('wincmd p')
    vcmd('cc')
  end
end

function M.list_file_diagnostics()
  local bufnr = api.nvim_get_current_buf()
  local diagnostics = vim.lsp.diagnostic.get(bufnr)
  if not diagnostics then
    return
  end

  local items = items_from_diagnostics(bufnr, diagnostics)
  render_diagnostics(items)
end

function M.list_workspace_diagnostics()
  render_diagnostics(vim.lsp.diagnostic.get_all())
end

function M.diagnostics_count(bufnr)
  return n_diagnostics_by_bufnr[bufnr] or 0
end

function M.on_diagnostics_changed()
  local diagnostics_by_buffer = vim.lsp.diagnostic.get_all()
  n_diagnostics_by_bufnr = {}
  for bufnr, diagnostics in pairs(diagnostics_by_buffer) do
    n_diagnostics_by_bufnr[bufnr] = #diagnostics
  end
end

function M.on_attach()
  helpers.augroup('fsouza__lsp_diagnostics', {
    {
      events = {'User LspDiagnosticsChanged'};
      command = [[lua require('fsouza.lsp.diagnostics').on_diagnostics_changed()]];
    };
  })
  vim.o.rulerformat = [[%25(%l,%c   %o    %1*%{v:lua.f.lsp.diagnostic_ruler()}%*%)]]
end

return M
