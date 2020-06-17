local M = {}

function M.rg()
  local input = vim.fn.input([[rg \ ]])
  if input ~= '' then vim.api.nvim_command('FzfRg ' .. input) end
end

return M
