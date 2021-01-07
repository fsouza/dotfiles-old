local api = vim.api

local M = {}

function M.set_theme_to_gitmessenger_popup()
  for _, winid in ipairs(api.nvim_list_wins()) do
    local bufnr = api.nvim_win_get_buf(winid)
    local _, current_syntax = pcall(api.nvim_buf_get_var, bufnr, 'current_syntax')
    if current_syntax == 'gitmessengerpopup' then
      require('fsouza.color').set_popup_winid(winid)
      return
    end
  end
end

return M
