local vfn = vim.fn

local M = {}

function M.buf_clear_all_diagnostics()
  local all_buffers = vfn.getbufinfo()
  local all_clients = vim.lsp.get_active_clients()
  for _, buffer in ipairs(all_buffers) do
    for _, client in ipairs(all_clients) do
      vim.lsp.diagnostic.clear(buffer.bufnr, client.id)
    end
  end
end

return M
