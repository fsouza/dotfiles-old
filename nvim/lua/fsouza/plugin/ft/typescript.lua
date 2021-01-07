local api = vim.api

return function(bufnr)
  api.nvim_buf_set_option(bufnr, 'formatexpr', '')
  api.nvim_buf_set_option(bufnr, 'formatprg', '')
end
