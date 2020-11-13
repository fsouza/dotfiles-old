local M = {}

local api = vim.api
local lsp = vim.lsp
local vcmd = vim.cmd

local items_from_diagnostics = function(bufnr, diagnostics)
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

local render_diagnostics = function(items)
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
  local items_list = {}
  for _, bufnr in ipairs(api.nvim_list_bufs()) do
    local diagnostics = vim.lsp.diagnostic.get(bufnr)
    local d_items = items_from_diagnostics(bufnr, diagnostics)
    for _, item in ipairs(d_items) do
      table.insert(items_list, item)
    end
  end
  render_diagnostics(items_list)
end

return M
