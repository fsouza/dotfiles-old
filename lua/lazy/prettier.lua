local M = {}

function M.enable_auto_format()
  vim.schedule(function()
    vim.b.LC_autoformat = false
    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua require('lazy/format').prettier()]])
  end)
end

return M
