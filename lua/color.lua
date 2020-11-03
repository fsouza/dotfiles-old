local api = vim.api
local themes = require('themes')
local colors = require('themes.colors')

local M = {}

function M.setup_popup(winid, ns_name)
  local theme = require('themes.popup')(ns_name)
  api.nvim_set_hl(theme, 'Normal', {fg = colors.black; bg = colors.gray});
  api.nvim_set_hl(theme, 'LineNr', {})
  api.nvim_set_decoration_provider(theme, {
    on_win = function(_, w)
      if w == winid then
        api.nvim_set_hl_ns(theme)
      else
        M.setup()
      end
    end;
  })
end

function M.setup()
  vim.o.background = 'light'
  api.nvim_set_hl_ns(themes.none)
end

return M
