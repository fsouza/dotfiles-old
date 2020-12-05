local helpers = require('fsouza.lib.nvim_helpers')

return function(bufnr)
  helpers.create_mappings({
    t = {{lhs = [[<esc><esc>]]; rhs = [[<c-\><c-n>]]; opts = {noremap = true}}};
  }, bufnr)
end
