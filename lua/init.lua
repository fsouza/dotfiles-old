local helpers = require('lib/nvim_helpers')

local initial_mappings = function()
  -- Disable ex mode. I'm not that smart.
  vim.api.nvim_set_keymap('n', 'Q', '', {})

  -- Remap the leader key.
  vim.api.nvim_set_keymap('n', '<Space>', '', {})
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
end

local syntax_and_filetype = function()
  helpers.exec_cmds({'syntax enable'; 'colorscheme none'; 'filetype plugin indent on'})

  vim.schedule(function()
    helpers.exec_cmds({
      [[match BadWhitespace /\s\+$/]]; [[autocmd BufEnter * match BadWhitespace /\s\+$/]]
    })
  end)
end

local py3_host_prog = function()
  local venvs_dir = vim.loop.os_getenv('VIRTUALENVS')
  if not venvs_dir then
    return
  end

  venvs_dir = string.gsub(venvs_dir, '/+$', '')
  local stat = vim.loop.fs_stat(venvs_dir)
  if not stat or stat.type ~= 'directory' then
    return
  end

  local vim_venv_bin = venvs_dir .. '/vim/bin'
  vim.loop.os_setenv('PATH', vim_venv_bin .. ':' .. vim.loop.os_getenv('PATH'))

  vim.g.python3_host_prog = vim_venv_bin .. '/python'
  vim.g.python3_host_skip_check = true
end

local global_vars = function()
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g['deoplete#enable_at_startup'] = true
end

local ui_options = function()
  vim.o.termguicolors = true
  vim.o.showcmd = false
  vim.o.laststatus = 0
  vim.o.ruler = true
  vim.o.rulerformat = [[%-14.(%l,%c   %o%)]]
  vim.o.guicursor = ''
  vim.o.mouse = ''
  vim.o.shortmess = 'filnxtToOFI'
end

local global_options = function()
  vim.o.completeopt = 'menu,longest,noselect'
  vim.o.hidden = true
  vim.o.backspace = 'indent,eol,start'
  vim.o.hlsearch = false
  vim.o.incsearch = false
  vim.o.foldenable = false
  vim.o.smartcase = true
  vim.o.wildmenu = true
  vim.o.wildmode = 'list:longest'
  vim.o.autoindent = true
  vim.o.smartindent = true
  vim.o.smarttab = true
  vim.o.errorbells = false
  vim.o.backup = false
  vim.o.swapfile = false
end

local rnu = function()
  if not vim.bo.readonly then
    vim.wo.relativenumber = true
  end
  vim.api.nvim_command([[autocmd BufEnter * if !&readonly|setlocal relativenumber|endif]])
end

function global_mappings()
  local win_mov_keys = {'h'; 'j'; 'k'; 'l'; 'w'}
  local maps = {
    n = {{lhs = '<leader>o'; rhs = helpers.cmd_map('only')}};
    i = {{lhs = '<c-d>'; rhs = '<del>'}};
    c = {
      {lhs = '<c-a>'; rhs = '<home>'; opts = {noremap = true}};
      {lhs = '<c-e>'; rhs = '<end>'; opts = {noremap = true}};
      {lhs = '<c-f>'; rhs = '<right>'; opts = {noremap = true}};
      {lhs = '<c-b>'; rhs = '<left>'; opts = {noremap = true}};
      {lhs = '<c-p>'; rhs = '<up>'; opts = {noremap = true}};
      {lhs = '<c-n>'; rhs = '<down>'; opts = {noremap = true}};
      {lhs = '<c-d>'; rhs = '<del>'; opts = {noremap = true}}
    }
  }

  for _, key in ipairs(win_mov_keys) do
    table.insert(maps.n, {lhs = '<leader>' .. key; rhs = helpers.cmd_map('wincmd ' .. key)})
  end
  helpers.create_mappings(maps)
end

local vim_plug = function()
  local path = vim.fn.stdpath('config') .. '/plugged'
  require('vim-plug')(path)
end

return function()
  initial_mappings()
  syntax_and_filetype()

  vim.schedule(global_options)
  vim.schedule(global_mappings)
  vim.schedule(rnu)

  ui_options()
  global_vars()

  py3_host_prog()
  vim_plug()

  if vim.loop.os_getenv('NVIM_BOOTSTRAP') then
    return
  end

  require('plugin/init')()
end
