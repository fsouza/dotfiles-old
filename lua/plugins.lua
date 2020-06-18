-- his is fine because there aren't a lot of plugins. If the number of plugins
-- starts to grow, I may need to look into some alternative (or maybe not, as
-- neovim may support plugin handling in lua in the future.
local M = {}

local helpers = require('nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      ['<leader>zz'] = {helpers.cmd_map('FzfFiles'); {silent = true}};
      ['<leader>;'] = {helpers.cmd_map('FzfFiles'); {silent = true}};
      ['<leader>zb'] = {helpers.cmd_map('FzfBuffers'); {silent = true}};
      ['<leader>zl'] = {helpers.cmd_map('FzfLines'); {silent = true}};
      ['<leader>zq'] = {helpers.cmd_map('FzfQuickfix'); {silent = true}};
      ['<leader>gg'] = {helpers.cmd_map('lua require(\'lazy/fuzzy\').rg()'); {silent = true}}
    }
  })
end

local setup_deoplete = function()
  vim.api.nvim_call_function('deoplete#custom#option',
                             {{auto_complete = false; auto_refresh_delay = 0}})
  vim.api.nvim_call_function('deoplete#custom#source', {'_'; 'matchers'; {'matcher_full_fuzzy'}})
  helpers.create_mappings({
    i = {['<c-x><c-o>'] = {'v:lua.f.complete()'; {expr = true; silent = true}}}
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

local create_prettier_command = function()
  vim.api.nvim_command([[command! PrettierFormat lua require('lazy/format').prettier()]])
end

function M.setup_async()
  vim.schedule(setup_fzf_mappings)
  vim.schedule(setup_deoplete)
  vim.schedule(setup_ultisnips)
  vim.schedule(setup_float_preview)
  vim.schedule(create_prettier_command)
end

return M
