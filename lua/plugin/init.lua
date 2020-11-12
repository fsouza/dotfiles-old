local vcmd = vim.cmd
local vfn = vim.fn
local helpers = require('lib.nvim_helpers')

local setup_fzf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<leader>zz'; rhs = helpers.cmd_map('FzfFiles'); opts = {silent = true}};
      {lhs = '<leader>;'; rhs = helpers.cmd_map('FzfCommands'); opts = {silent = true}};
      {lhs = '<leader>zb'; rhs = helpers.cmd_map('FzfBuffers'); opts = {silent = true}};
      {lhs = '<leader>zl'; rhs = helpers.cmd_map('FzfLines'); opts = {silent = true}};
      {
        lhs = '<leader>zj';
        rhs = helpers.cmd_map([[lua require('plugin.fuzzy').fzf_here()]]);
        opts = {silent = true};
      };
      {
        lhs = '<leader>gg';
        rhs = helpers.cmd_map([[lua require('plugin.fuzzy').rg()]]);
        opts = {silent = true};
      };
      {
        lhs = '<leader>gw';
        rhs = helpers.cmd_map([[lua require('plugin.fuzzy').rg_cword()]]);
        opts = {silent = true};
      };
    };
  })
end

local setup_qf_mappings = function()
  helpers.create_mappings({
    n = {
      {lhs = '<cr>'; rhs = helpers.cmd_map('cc')};
      {lhs = '<c-n>'; rhs = helpers.cmd_map('cnext')};
      {lhs = '<c-p>'; rhs = helpers.cmd_map('cprevious')};
      {lhs = '<down>'; rhs = helpers.cmd_map('cnext')};
      {lhs = '<up>'; rhs = helpers.cmd_map('cprevious')};
    };
  })
end

local setup_terminal_commands_and_mapping = function()
  vcmd([[command! -nargs=? T lua require('plugin.terminal').terminal_here(<f-args>)]])
  helpers.create_mappings({
    n = {
      {lhs = '<c-t>'; rhs = helpers.cmd_map([[lua require('plugin.terminal').terminal_cmd()]])};
      {lhs = '<c-s-t>'; rhs = helpers.cmd_map([[lua require('plugin.terminal').terminal_here()]])};
    };
  })
end

local setup_autofmt_commands = function()
  vcmd([[command! ToggleAutofmt lua require('lib.autofmt').toggle()]])
  vcmd([[command! ToggleGlobalAutofmt lua require('lib.autofmt').toggle_g()]])
end

local setup_completion = function()
  vim.g.completion_enable_auto_popup = 0
end

local setup_hlyank = function()
  helpers.augroup('yank_highlight', {
    {
      events = {'TextYankPost'};
      targets = {'*'};
      command = [[lua require('vim.highlight').on_yank({higroup = 'HlYank'; timeout = 200; on_macro = false})]];
    };
  })
end

local setup_global_ns = function()
  _G.f = require('plugin.global')
end

local setup_word_replace = function()
  helpers.create_mappings({
    n = {
      {
        lhs = '<leader>e';
        rhs = helpers.cmd_map([[lua require('plugin.word_sub').run()]]);
        opts = {silent = true};
      };
    };
  })
end

local setup_spell = function()
  helpers.augroup('auto_spell', {
    {
      events = {'FileType'};
      targets = {'gitcommit'; 'markdown'; 'text'};
      command = [[setlocal spell]];
    };
  })
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
    'json';
    'javascript';
    'typescript';
    'css';
    'html';
    'typescriptreact';
    'yaml';
  }
  helpers.augroup('auto_prettierd', {
    {
      events = {'FileType'};
      targets = auto_fmt_fts;
      command = [[lua require('plugin.prettierd').enable_auto_format(vim.fn.expand('<abuf>'))]];
    };
    {
      events = {'FileType'};
      targets = auto_fmt_fts;
      command = [[nmap <buffer> <silent> <leader>f ]] ..
        [[<cmd>lua require('plugin.prettierd').format(vim.fn.expand('<abuf>'))<cr>]];
    };
  })
end

local trigger_ft = function()
  if vim.bo.filetype and vim.bo.filetype ~= '' then
    vcmd([[doautocmd FileType ]] .. vim.bo.filetype)
  end
end

local setup_lsp = function()
  require('lc.init')
  vim.schedule(function()
    vcmd([[command! LspStop lua require('lc.restart').stop()]])
  end)
end

local setup_shortcuts = function()
  require('plugin.shortcut').register('Vimfiles', vfn.stdpath('config'))
  require('plugin.shortcut').register('Dotfiles', vfn.expand('~/.dotfiles'))
  vim.schedule(function()
    vcmd([[command! Gcd lua require('plugin.shortcut').cd_git(vim.fn.expand('%:p'))]])
  end)
end

local setup_git_messenger = function()
  helpers.augroup('git-messenger-popup', {
    {
      events = {'FileType'};
      targets = {'gitmessengerpopup'};
      command = [[lua require('plugin.popup').set_theme_to_gitmessenger_popup()]];
    };
  })
end

do
  local schedule = vim.schedule
  schedule(function()
    require('lib.cleanup').setup()
  end)
  schedule(setup_completion)
  schedule(setup_editorconfig)
  schedule(setup_global_ns)
  schedule(setup_fzf_mappings)
  schedule(setup_hlyank)
  schedule(setup_qf_mappings)
  schedule(setup_terminal_commands_and_mapping)
  schedule(setup_autofmt_commands)
  schedule(setup_word_replace)
  schedule(setup_spell)
  schedule(setup_prettierd)
  schedule(setup_lsp)
  schedule(setup_shortcuts)
  schedule(setup_git_messenger)
  schedule(function()
    require('colorizer').setup({'css'; 'javascript'; 'html'; 'lua'; 'htmldjango'})
  end)
  schedule(function()
    require('plugin.ts')
  end)
  schedule(function()
    require('plugin.ft').setup()
  end)
  schedule(trigger_ft)
end
