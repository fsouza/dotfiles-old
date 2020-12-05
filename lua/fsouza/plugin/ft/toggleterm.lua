local api = vim.api

local helpers = require('fsouza.lib.nvim_helpers')

return function()
  local bufnr = api.nvim_get_current_buf()
  helpers.create_mappings({
    t = {{lhs = [[<esc><esc>]]; rhs = [[<c-\><c-n>]]; opts = {noremap = true}}};
  }, bufnr)
end
