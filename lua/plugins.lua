-- his is fine because there aren't a lot of plugins. If the number of plugins
-- starts to grow, I may need to look into some alternative (or maybe not, as
-- neovim may support plugin handling in lua in the future.

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

local setup_deoplete = function()
  vim.api.nvim_call_function('deoplete#custom#option', {
    {
      auto_complete = false;
      auto_refresh_delay = 0;
    };
  })
  vim.api.nvim_call_function('deoplete#custom#source', {
    '_';
    'matchers';
    { 'matcher_full_fuzzy' };
  })
  helpers.create_mappings({
    i = {
      ['<c-x><c-o>'] = { 'fsouza#complete#Complete()'; { expr = true; silent = true } };
    };
  })
end

local setup_ultisnips = function()
  local vars = {
    UltiSnipsExpandTrigger = '<tab>';
    UltiSnipsJumpForwardTrigger = '<c-j>';
    UltiSnipsJumpBackwardTrigger = '<c-k>';
  }

  for name, value in pairs(vars) do
    vim.api.nvim_set_var(name, value)
  end
end

function M.setup_async()
  vim.schedule(setup_fzf_mappings)
  vim.schedule(setup_deoplete)
  vim.schedule(setup_ultisnips)
end

return M
