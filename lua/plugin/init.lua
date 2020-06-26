local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfPreviewProjectFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfCommands'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfPreviewBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfPreviewLines'); opts = {silent = true}};
      {lhs = '<leader>zq'; rhs = helpers.cmd_map('FzfPreviewQuickfix'); opts = {silent = true}};
      {lhs = '<leader>gs'; rhs = helpers.cmd_map('FzfPreviewGitStatus'); opts = {silent = true}};
      {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map('lua require("plugin.fuzzy").rg()');
        opts = {silent = true};
      }; {
        lhs = '<leader>gw';
        rhs = helpers.cmd_map('lua require("plugin.fuzzy").rg_cword()');
        opts = {silent = true};
      };
    };
  })
end

local setup_terminal_commands = function()
  vcmd([[command! T lua require('plugin.terminal').terminal_here()]])
end

local setup_completion = function()
  vim.g.completion_trigger_on_delete = 1
  vim.g.completion_confirm_key = [[\<C-y>]]
  vim.g.completion_enable_snippet = 'UltiSnips'
  vim.g.completion_matching_strategy_list = {'exact'; 'fuzzy'}
  helpers.create_mappings({
    i = {
      {
        lhs = '<c-x><c-o>';
        rhs = 'completion#trigger_completion()';
        opts = {expr = true; silent = true};
      }; {lhs = '<cr>'; rhs = [[pumvisible() ? "\<c-e>\<cr>" : "\<cr>"]]; opts = {expr = true}};
    };
  })
end

local setup_ultisnips = function()
  vim.g.UltiSnipsExpandTrigger = '<tab>'
  vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
end

local setup_hlyank = function()
  vcmd([[augroup yank_highlight]])
  vcmd([[autocmd!]])
  vcmd([[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('HlYank', 300)]])
  vcmd([[augroup END]])
end

local setup_global_ns = function()
  _G.f = require('plugin.global')
end

local setup_format_comands = function()
  vcmd([[command! LuaFormat lua require('plugin.format').lua()]])
  vcmd([[augroup auto_lua_format]])
  vcmd([[autocmd!]])
  vcmd([[autocmd FileType lua lua require('plugin.format').enable_lua_auto_format()]])
  vcmd([[augroup END]])
end

local setup_word_replace = function()
  helpers.create_mappings({
    n = {
      {
        lhs = '<leader>e';
        rhs = helpers.cmd_map('lua require("plugin.word_sub").run()');
        opts = {silent = true};
      };
    };
  })
end

local setup_spell = function()
  local filetypes = {'gitcommit'; 'markdown'; 'text'}
  vcmd([[augroup auto_spell]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s setlocal spell]], table.concat(filetypes, ',')))
  vcmd([[augroup END]])
end

local setup_editorconfig = function()
  require('plugin.editor_config').enable()
  vim.schedule(function()
    vcmd([[command! EnableEditorConfig lua require('plugin.editor_config').enable()]])
    vcmd([[command! DisableEditorConfig lua require('plugin.editor_config').disable()]])
  end)
end

local setup_prettierd = function()
  local auto_fmt_fts = {'json'; 'javascript'; 'typescript'; 'css'; 'html'; 'typescriptreact'}
  vcmd([[command! PrettierFormat lua require('plugin.prettierd').format()]])
  vcmd([[augroup auto_prettierd]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s lua require('plugin.prettierd').enable_auto_format()]],
                     table.concat(auto_fmt_fts, ',')))
  vcmd([[augroup END]])
end

local ftdetect = function()
  local p_mapping = {['go.mod'] = 'gomod'}
  vcmd([[augroup ftdetect]])
  vcmd([[autocmd!]])
  for pattern, ft in pairs(p_mapping) do
    vcmd(string.format([[autocmd BufEnter %s set ft=%s]], pattern, ft))
  end
  vcmd([[augroup END]])
end

local trigger_ft = function()
  if vim.bo.filetype and vim.bo.filetype ~= '' then
    vcmd([[doautocmd FileType ]] .. vim.bo.filetype)
  end
end

do
  local schedule = vim.schedule
  schedule(setup_completion)
  schedule(setup_editorconfig)
  schedule(setup_global_ns)
  schedule(setup_fzf_mappings)
  schedule(setup_ultisnips)
  schedule(setup_hlyank)
  schedule(setup_format_comands)
  schedule(setup_terminal_commands)
  schedule(setup_word_replace)
  schedule(setup_spell)
  schedule(setup_prettierd)
  schedule(ftdetect)
  schedule(function()
    require('lc.init')
    require('plugin.ts')
    trigger_ft()
  end)
end
