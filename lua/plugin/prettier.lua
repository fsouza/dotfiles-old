local M = {}

local nvim_command = vim.api.nvim_command

function M.enable_auto_format()
  vim.schedule(function()
    vim.b.LC_autoformat = false
    nvim_command(
      [[autocmd BufWritePre <buffer> lua require('plugin/format').auto('Prettier_autoformat', require('plugin/format').prettier)]])
  end)
end

return M
