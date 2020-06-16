local M = {}

local helpers = require('nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      ['<leader>zz'] = { helpers.cmd_map('FzfFiles'); { silent = true } };
      ['<leader>;'] = { helpers.cmd_map('FzfFiles'); { silent = true } };
      ['<leader>zb'] = { helpers.cmd_map('FzfBuffers'); { silent = true } };
      ['<leader>zl'] = { helpers.cmd_map('FzfLines'); { silent = true } };
      ['<leader>zq'] = { helpers.cmd_map('FzfQuickfix'); { silent = true } };
      ['<leader>zg'] = { helpers.cmd_map('call fsouza#fuzzy#Rg()'); { silent = true } };
    };
  })
end

function M.setup_async()
  vim.schedule(setup_fzf_mappings)
end

return M
