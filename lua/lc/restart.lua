return function()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd([[e!]])
end
