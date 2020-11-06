local fun = require('fun')

local vfn = vim.fn

local M = {}

function M.set_theme_to_gitmessenger_popup()
  fun.iter(vfn.getbufinfo()):filter(function(b)
    return b.variables.current_syntax == 'gitmessengerpopup'
  end):filter(function(b)
    return #b.windows > 0
  end):map(function(b)
    return b.windows[1]
  end):take_n(1):each(function(winid)
    require('color').set_popup_winid(winid)
  end)
end

return M
