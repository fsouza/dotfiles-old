local api = vim.api
local themes = require('themes')

local M = {}

local _themes = {}

function M.set_popup_winid(winid)
  _themes[winid] = themes.popup
end

function M.setup()
  vim.o.background = 'light'
  local cb = function(_, winid)
    local theme = _themes[winid] or themes.none
    api.nvim_set_hl_ns(theme)
  end
  api.nvim_set_decoration_provider(themes.none, {on_win = cb; on_line = cb})
end

return M
