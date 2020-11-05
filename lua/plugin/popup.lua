local vfn = vim.fn

local M = {}

function M.set_theme_to_gitmessenger_popup()
  local bufinfo = vfn.getbufinfo()
  for _, buffer in ipairs(bufinfo) do
    if buffer.variables.current_syntax == 'gitmessengerpopup' then
      local win_id = next(buffer.windows)
      if win_id then
        require('color').set_popup_winid(win_id)
      end
      return
    end
  end
end

return M
