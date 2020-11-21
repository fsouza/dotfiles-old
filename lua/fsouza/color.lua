local api = vim.api
local themes = require('fsouza.themes')

local M = {}

local _default_theme

local _themes = {}

local _popup_cb

-- Should we support more than one cb?
function M.add_popup_cb(cb)
  _popup_cb = cb
end

function M.set_popup_winid(winid)
  if winid then
    _themes[winid] = themes.popup
  end
end

function M.set_default_theme(theme_ns)
  _default_theme = theme_ns
end

local gc = function()
  for winid in pairs(_themes) do
    if not api.nvim_win_is_valid(winid) then
      _themes[winid] = nil
    end
  end
end

local find_theme = function(curr_winid)
  if _popup_cb then
    local winid = _popup_cb()
    if winid == curr_winid then
      return themes.popup
    end
  end
  return _default_theme
end

function M.setup()
  vim.o.background = 'light'
  _default_theme = themes.none
  local cb = function(_, winid)
    local theme = _themes[winid]
    if not theme then
      theme = find_theme(winid)
    end
    api.nvim_set_hl_ns(theme)
    vim.schedule(gc)
  end
  api.nvim_set_decoration_provider(themes.none, {on_win = cb; on_line = cb})
end

return M
