local vfn = vim.fn
local nvim_command = vim.api.nvim_command

local M = {}

function M.trim()
  local view = vfn.winsaveview()
  pcall(function()
    nvim_command([[silent! keeppatterns %s/\s\+$//e]])
  end)
  vfn.winrestview(view)
end

return M
