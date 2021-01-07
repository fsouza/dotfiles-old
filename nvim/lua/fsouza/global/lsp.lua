local api = vim.api

local M = {}

function M.diagnostic_ruler()
  local bufnr = api.nvim_get_current_buf()
  local count = require('fsouza.lsp.diagnostics').diagnostics_count(bufnr)
  if count == 0 then
    return ''
  end
  return string.format('d:%d', count)
end

return M
