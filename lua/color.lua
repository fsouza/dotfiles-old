local api = vim.api
local themes = require('themes')

local M = {}

local _themes = {}

function M.set_popup_winid(winid)
  _themes[winid] = themes.popup
end

-- TODO(fsouza): potentially remove this once nvim_set_hl can be set to
-- windows?
function M.setup()
  vim.o.background = 'light'
  api.nvim_set_decoration_provider(themes.none, {
    on_win = function(_, winid)
      local theme = _themes[winid] or themes.none
      api.nvim_set_hl_ns(theme)
    end;
  })
end

return M
