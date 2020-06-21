local M = {}

local api = vim.api
local vfn = vim.fn

function M.run()
  local word = vfn.expand('<cword>')
  api.nvim_input([[:%s/\v<lt>]] .. word .. [[>//gc<left><left><left>]])
end

return M
