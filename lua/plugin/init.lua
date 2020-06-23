local nvim_command = vim.api.nvim_command
local vfn = vim.fn
local helpers = require('lib/nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfCommands'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}};
      {lhs = '<leader>zq'; rhs = helpers.cmd_map('FzfQuickfix'); opts = {silent = true}}; {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map('lua require("plugin/fuzzy").rg()');
        opts = {silent = true};
      }; {
        lhs = '<leader>gw';
        rhs = helpers.cmd_map('lua require("plugin/fuzzy").rg_cword()');
        opts = {silent = true};
      };
    };
  })
end

local setup_deoplete = function()
  vfn['deoplete#custom#option']({auto_complete = false; auto_refresh_delay = 0})
  vfn['deoplete#custom#source']('_', 'matchers', {'matcher_full_fuzzy'})
  helpers.create_mappings({
    i = {{lhs = '<c-x><c-o>'; rhs = 'v:lua.f.complete()'; opts = {expr = true; silent = true}}};
  })
end

local setup_ultisnips = function()
  vim.g.UltiSnipsExpandTrigger = '<tab>'
  vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
end

local setup_float_preview = function()
  vim.g['float_preview#auto_close'] = false
  nvim_command([[autocmd InsertLeave * if pumvisible() == 0|call float_preview#close()|endif]])
end

local setup_hlyank = function()
  nvim_command(
    [[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('HlYank', 300)]])
end

local setup_global_ns = function()
  _G.f = require('plugin/global')
end

local setup_format_comands = function()
  nvim_command([[command! LuaFormat lua require('plugin/format').lua()]])
end

local setup_word_replace = function()
  helpers.create_mappings({
    n = {
      {
        lhs = '<leader>e';
        rhs = helpers.cmd_map('lua require("plugin/word_sub").run()');
        opts = {silent = true};
      };
    };
  })
end

local setup_spell = function()
  local filetypes = {'gitcommit'; 'markdown'; 'text'}
  for _, ft in pairs(filetypes) do
    if vim.bo.filetype == ft then
      vim.wo.spell = true
    end
    nvim_command(string.format([[autocmd FileType %s setlocal spell]], ft))
  end
end

local setup_editorconfig = function()
  require('plugin/editor_config').enable()
  vim.schedule(function()
    nvim_command([[command! EnableEditorConfig lua require('plugin/editor_config').enable()]])
    nvim_command([[command! DisableEditorConfig lua require('plugin/editor_config').disable()]])
  end)
end

do
  local schedule = vim.schedule
  schedule(setup_editorconfig)
  schedule(setup_global_ns)
  schedule(setup_fzf_mappings)
  schedule(setup_deoplete)
  schedule(setup_ultisnips)
  schedule(setup_float_preview)
  schedule(setup_hlyank)
  schedule(setup_format_comands)
  schedule(setup_word_replace)
  schedule(setup_spell)
  schedule(function()
    require('lc/init')
  end)
end
