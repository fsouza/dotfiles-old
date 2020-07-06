local M = {}

function M.on_yank()
  require('vim.highlight').on_yank({higroup = 'HlYank'; timeout = 200; on_macro = false})
end

return M
