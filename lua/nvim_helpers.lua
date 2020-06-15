local M = {}

function M.cmd_map(cmd)
  return string.format('<cmd>%s<cr>', cmd)
end

return M
