local M = {}

local vfn = vim.fn

function format_items(items)
  local lines = {}
  local prefix = vfn.getcwd() .. '/'
  for _, item in pairs(items) do
    local filename = item.filename
    if vim.startswith(filename, prefix) then
      filename = string.sub(filename, string.len(prefix) + 1)
    end
    table.insert(lines, string.format('%s:%d:%d:%s', filename, item.lnum, item.col, item.text))
  end
  return lines
end

function M.send(items)
  vfn['local#Lsp_fzf'](format_items(items))
end

return M
