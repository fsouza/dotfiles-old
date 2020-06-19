local M = {}

local fzf_actions = {['ctrl-t'] = 'tabedit'; ['ctrl-x'] = 'split'; ['ctrl-v'] = 'vsplit'}
local nvim_command = vim.api.nvim_command
local nvim_input = vim.api.nvim_input

function M.handle_lsp_line(lines)
  if #lines < 2 then
    return
  end

  local action = fzf_actions[lines[1]] or 'edit'
  local _, _, filename, lnum, cnum = string.find(lines[2], '([^:]+):(%d+):(%d+)')
  if not filename then
    return
  end

  nvim_command(string.format('%s %s', action, filename))
  vim.fn.cursor(lnum, cnum)
  nvim_input('zz')
end

return M
