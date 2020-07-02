local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfCommands'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}}; {
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
  vim.g.completion_matching_strategy_list = {'exact'; 'fuzzy'}
  vim.g.completion_chain_complete_list = {
    {complete_items = {'lsp'}}; {complete_items = {'buffers'}}; {mode = {'<c-p>'}};
    {mode = {'<c-n>'}};
  }
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
  vcmd([[augroup filetype_lua]])
  vcmd([[autocmd!]])
  vcmd([[autocmd FileType lua lua require('plugin.format').enable_lua_auto_format()]])
  vcmd(string.format(
         [[autocmd FileType lua nmap <buffer> <silent> <leader>f <cmd>lua require('plugin.format').lua()<cr>']]))
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
  local auto_fmt_fts = {
    'json'; 'javascript'; 'typescript'; 'css'; 'html'; 'typescriptreact'; 'yaml';
  }
  vcmd([[augroup auto_prettierd]])
  vcmd([[autocmd!]])
  vcmd(string.format([[autocmd FileType %s lua require('plugin.prettierd').enable_auto_format()]],
                     table.concat(auto_fmt_fts, ',')))
  vcmd(string.format(
         [[autocmd FileType %s nmap <buffer> <silent> <leader>f <cmd>lua require('plugin.prettierd').format()<cr>']],
         table.concat(auto_fmt_fts, ',')))
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
  schedule(setup_hlyank)
  schedule(setup_format_comands)
  schedule(setup_terminal_commands)
  schedule(setup_word_replace)
  schedule(setup_spell)
  schedule(setup_prettierd)
  schedule(function()
    require('lc.init')
    require('plugin.ts')
    trigger_ft()
  end)
end
