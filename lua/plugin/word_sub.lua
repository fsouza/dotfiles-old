local M = {}

local nvim_input = vim.api.nvim_input
local vfn = vim.fn

function M.run()
  local word = vfn.expand('<cword>')
  nvim_input([[:%s/\v<lt>]] .. word .. [[>//gc<left><left><left>]])
end

return M
