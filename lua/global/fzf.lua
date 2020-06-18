local M = {}

local fzf_actions = {['ctrl-t'] = 'tabedit'; ['ctrl-x'] = 'split'; ['ctrl-v'] = 'vsplit'}

function M.handle_lsp_line(lines)
  print(vim.inspect(lines))
  if #lines < 2 then
    return
  end

  local action = fzf_actions[lines[1]] or 'edit'
  local _, _, filename, lnum, cnum = string.find(lines[2], '([^:]+):(%d+):(%d+)')
  if not filename then
    return
  end

  vim.api.nvim_command(string.format('%s %s', action, filename))
  vim.fn.cursor(lnum, cnum)
  vim.api.nvim_input('zz')
end

return M
