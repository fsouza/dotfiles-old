local api = vim.api
local themes = require('themes')

local M = {}

local _default_theme

local _themes = {}

function M.set_popup_bufnr(bufnr)
  if bufnr then
    _themes[bufnr] = themes.popup
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

function M.setup()
  vim.o.background = 'light'
  _default_theme = themes.none
  local cb = function(bufnr)
    local theme = _themes[bufnr] or _default_theme
    api.nvim_set_hl_ns(theme)
    vim.schedule(gc)
  end
  local ns = api.nvim_create_namespace('fsouza.color')
  api.nvim_set_decoration_provider(ns, {
    on_win = function(_, _, bufnr)
      cb(bufnr)
    end;
    on_line = function(_, _, bufnr)
      cb(bufnr)
    end;
    on_buf = function(_, bufnr)
      cb(bufnr)
    end;
  })
end

return M
