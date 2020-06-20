local M = {}

local api = vim.api
local lsp = vim.lsp
local nvim_command = vim.api.nvim_command
local nvim_input = vim.api.nvim_input

local fzf_actions = {['ctrl-t'] = 'tabedit'; ['ctrl-x'] = 'split'; ['ctrl-v'] = 'vsplit'}

local lines_to_loc_list = function(lines)
  local items = {}
  for _, line in ipairs(lines) do
    local _, _, filename, lnum, col, text = string.find(line, '([^:]+):(%d+):(%d+):(.*)')
    if filename then
      table.insert(items, {filename = filename; lnum = lnum; col = col; text = text})
    end
  end
  return items
end

function M.handle_lsp_line(lines)
  if #lines < 2 then
    return
  end

  local first_line = table.remove(lines, 1)
  local action = fzf_actions[first_line] or 'edit'
  local loc_list = lines_to_loc_list(lines)
  if #loc_list < 1 then
    return
  end

  if #loc_list == 1 then
    local item = loc_list[1]
    nvim_command(string.format('%s %s', action, item.filename))
    vim.fn.cursor(item.lnum, item.col)
    nvim_input('zz')
  else
    lsp.util.set_loclist(loc_list)
    api.nvim_command('lopen')
    api.nvim_command('wincmd p')
    api.nvim_command('ll')
  end
end

return M
