local M = {}

function M.enable_auto_format()
  vim.schedule(function()
    vim.api.nvim_buf_set_var(0, 'LC_autoformat', false)
    vim.api.nvim_command([[autocmd BufWritePre <buffer> call fsouza#format#Prettier()]])
  end)
end

return M
