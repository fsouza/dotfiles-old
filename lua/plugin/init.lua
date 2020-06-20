local api = vim.api
local helpers = require('lib/nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}};
      {lhs = '<leader>zq'; rhs = helpers.cmd_map('FzfQuickfix'); opts = {silent = true}}; {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map('lua require("plugin/fuzzy").rg()');
        opts = {silent = true}
      }
    }
  })
end

local setup_deoplete = function()
  api.nvim_call_function('deoplete#custom#option',
                             {{auto_complete = false; auto_refresh_delay = 0}})
  api.nvim_call_function('deoplete#custom#source', {'_'; 'matchers'; {'matcher_full_fuzzy'}})
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
  api.nvim_command(
    [[autocmd InsertLeave * if pumvisible() == 0|call float_preview#close()|endif]])
end

local setup_hlyank = function()
  api.nvim_command(
    [[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('HlYank', 300)]])
end

local setup_global_ns = function()
  _G.f = require('plugin/global')
end

local setup_lua_format_command = function()
  api.nvim_command([[command! LuaFormat lua require('plugin/format').lua()]])
end

do
  vim.schedule(setup_global_ns)
  vim.schedule(setup_fzf_mappings)
  vim.schedule(setup_deoplete)
  vim.schedule(setup_ultisnips)
  vim.schedule(setup_float_preview)
  vim.schedule(setup_hlyank)
  vim.schedule(setup_lua_format_command)
  vim.schedule(function()
    require('lc/init')
  end)
end
