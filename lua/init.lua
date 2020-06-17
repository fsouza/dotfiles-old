local api = vim.api
local loop = vim.loop
local helpers = require('nvim_helpers')

local M = {}

local remap_leader_key = function()
  api.nvim_set_keymap('n', 'Q', '', {})
  api.nvim_set_keymap('n', '<Space>', '', {})
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
end

local setup_syntax_and_filetype = function()
  helpers.exec_cmds({'syntax enable'; 'colorscheme none'; 'filetype plugin indent on'})

  vim.schedule(function()
    helpers.exec_cmds({
      [[match BadWhitespace /\s\+$/]]; [[autocmd BufEnter * match BadWhitespace /\s\+$/]]
    })
  end)
end

local setup_python = function()
  local venvs_dir = loop.os_getenv('VIRTUALENVS')
  if not venvs_dir then
    return
  end

  venvs_dir = string.gsub(venvs_dir, '/+$', '')
  local stat = loop.fs_stat(venvs_dir)
  if not stat or stat.type ~= 'directory' then
    return
  end

  local vim_venv_bin = venvs_dir .. '/vim/bin'
  loop.os_setenv('PATH', vim_venv_bin .. ':' .. loop.os_getenv('PATH'))

  vim.g.python3_host_prog = vim_venv_bin .. '/python'
  vim.g.python3_host_skip_check = true
end

local set_global_vars = function()
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g['deoplete#enable_at_startup'] = true
end

local set_ui_options = function()
  vim.o.termguicolors = true
  vim.o.showcmd = false
  vim.o.laststatus = 0
  vim.o.ruler = true
  vim.o.rulerformat = [[%-14.(%l,%c   %o%)]]
  vim.o.guicursor = ''
  vim.o.mouse = ''
  vim.o.shortmess = 'filnxtToOFI'
end

local set_global_options = function()
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

local set_window_options = function()
  vim.wo.relativenumber = true
  api.nvim_command([[autocmd WinEnter * set relativenumber]])
end

function setup_global_mappings()
  local win_mov_keys = {'h'; 'j'; 'k'; 'l'; 'w'}
  local maps = {n = {['<leader>o'] = {helpers.cmd_map('only')}}; i = {['<c-d>'] = {'<del>'}}}

  for _, key in ipairs(win_mov_keys) do
    api.nvim_set_keymap('n', '<leader>' .. key, helpers.cmd_map('wincmd ' .. key), {})
  end
  helpers.create_mappings(maps)
end

local setup_plug = function()
  local path = vim.fn.stdpath('config') .. '/plugged'
  require('vim-plug')(path)
end

local setup_lua_globals = function()
  _G.lc_helpers = require('global/lc_helpers')
end

function M.setup()
  vim.schedule(set_window_options)
  vim.schedule(set_global_options)

  remap_leader_key()
  setup_syntax_and_filetype()
  set_ui_options()
  set_global_vars()
  setup_global_mappings()

  setup_python()
  setup_plug()

  if loop.os_getenv('NVIM_BOOTSTRAP') then
    return
  end

  setup_lua_globals()
  vim.schedule(require('lc').setup)
  require('plugins').setup_async()
end

return M
