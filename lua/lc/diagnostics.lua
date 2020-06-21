local M = {}

local api = vim.api
local lsp = vim.lsp

function M.show_line_diagnostics()
  local prefix = '- '
  local indent = '  '
  local lines = {'Diagnostics:'; ''}
  local line_diagnostics = lsp.util.get_line_diagnostics()
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  for _, diagnostic in pairs(line_diagnostics) do
    local message_lines = vim.split(diagnostic.message, '\n', true)
    table.insert(lines, prefix .. message_lines[1])
    for j = 2, #message_lines do
      table.insert(lines, indent .. message_lines[j])
    end
  end
  return lsp.util.open_floating_preview(lines, 'plaintext')
end

function M.list_file_diagnostics()
  local fname = vim.fn.expand('%')
  local bufnr = api.nvim_get_current_buf()
  local diagnostics = lsp.util.diagnostics_by_buf[bufnr]
  if not diagnostics or vim.tbl_isempty(diagnostics) then
    return
  end

  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local pos = diagnostic.range.start
    table.insert(items, {
      filename = fname;
      lnum = pos.line;
      col = pos.character;
      text = diagnostic.message;
    })
  end
  lsp.util.set_qflist(items)
  api.nvim_command('copen')
  api.nvim_command('wincmd p')
  api.nvim_command('cc')
end

return M
