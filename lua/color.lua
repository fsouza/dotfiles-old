local api = vim.api
local themes = require('themes')

local M = {}

function M.setup()
  vim.o.background = 'light'
  api.nvim_set_hl_ns(themes.none)
end

return M
