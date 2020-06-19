-- his is fine because there aren't a lot of plugins. If the number of plugins
-- starts to grow, I may need to look into some alternative (or maybe not, as
-- neovim may support plugin handling in lua in the future.
local M = {}

local helpers = require('nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}};
      {lhs = '<leader>zq'; rhs = helpers.cmd_map('FzfQuickfix'); opts = {silent = true}}; {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map('lua require(\'lazy/fuzzy\').rg()');
        opts = {silent = true}
      }
    }
  })
end

local setup_deoplete = function()
  vim.api.nvim_call_function('deoplete#custom#option',
                             {{auto_complete = false; auto_refresh_delay = 0}})
  vim.api.nvim_call_function('deoplete#custom#source', {'_'; 'matchers'; {'matcher_full_fuzzy'}})
  helpers.create_mappings({
    i = {{lhs = '<c-x><c-o>'; rhs = 'v:lua.f.complete()'; opts = {expr = true; silent = true}}}
  })
end

local setup_ultisnips = function()
  vim.g.UltiSnipsExpandTrigger = '<tab>'
  vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
end

local setup_float_preview = function()
  vim.g['float_preview#auto_close'] = false
  vim.api.nvim_command(
    [[autocmd InsertLeave * if pumvisible() == 0|call float_preview#close()|endif]])
end

function M.setup_async()
  vim.schedule(setup_fzf_mappings)
  vim.schedule(setup_deoplete)
  vim.schedule(setup_ultisnips)
  vim.schedule(setup_float_preview)
end

return M
