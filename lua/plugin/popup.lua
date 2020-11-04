local vfn = vim.fn

local M = {}

function M.set_theme_to_gitmessenger_popup()
  local bufinfo = vfn.getbufinfo()
  for _, buffer in ipairs(bufinfo) do
    if buffer.variables.current_syntax == 'gitmessengerpopup' then
      for _, win_id in ipairs(buffer.windows) do
        require('color').setup_popup(win_id)
      end
    end
  end
end

return M
