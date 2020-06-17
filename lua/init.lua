local api = vim.api
local loop = vim.loop
local helpers = require('nvim_helpers')

local M = {}

local remap_leader_key = function()
  api.nvim_set_keymap('n', 'Q', '', {})
  api.nvim_set_keymap('n', '<Space>', '', {})
  api.nvim_set_var('mapleader', ' ')
  api.nvim_set_var('maplocalleader', ' ')
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
  if not venvs_dir then return end

  venvs_dir = string.gsub(venvs_dir, '/+$', '')
  local stat = loop.fs_stat(venvs_dir)
  if not stat or stat.type ~= 'directory' then return end

  local vim_venv_bin = venvs_dir .. '/vim/bin'
  loop.os_setenv('PATH', vim_venv_bin .. ':' .. loop.os_getenv('PATH'))

  api.nvim_set_var('python3_host_prog', vim_venv_bin .. '/python')
  api.nvim_set_var('python3_host_skip_check', 1)
end

local set_global_vars = function()
  local vars = {
    netrw_banner = 0;
    netrw_liststyle = 3;
    fzf_command_prefix = 'Fzf';
    ['deoplete#enable_at_startup'] = true
  }
  for name, value in pairs(vars) do api.nvim_set_var(name, value) end
end

local set_global_options = function()
  local options = {
    termguicolors = true;
    completeopt = 'menu,longest,noselect';
    hidden = true;
    showcmd = false;
    laststatus = 0;
    ruler = true;
    rulerformat = [[%-14.(%l,%c   %o%)]];
    backspace = 'indent,eol,start';
    hlsearch = false;
    incsearch = false;
    foldenable = false;
    smartcase = true;
    wildmenu = true;
    wildmode = 'list:longest';
    autoindent = true;
    smartindent = true;
    smarttab = true;
    guicursor = '';
    mouse = '';
    shortmess = 'filnxtToOFI';
    errorbells = false;
    backup = false;
    swapfile = false;
    undofile = true
  }
  for key, value in pairs(options) do api.nvim_set_option(key, value) end
end

local set_window_options = function()
  local options = {relativenumber = true}
  for key, value in pairs(options) do api.nvim_win_set_option(0, key, value) end
end

function setup_global_mappings()
  local win_mov_keys = {'h'; 'j'; 'k'; 'l'; 'w'}
  local maps = {
    n = {['<leader>o'] = {helpers.cmd_map('only')}};
    i = {['<c-d>'] = {'<del>'}}
  }

  for _, key in ipairs(win_mov_keys) do
    api.nvim_set_keymap('n', '<leader>' .. key, helpers.cmd_map('wincmd ' .. key), {})
  end
  helpers.create_mappings(maps)
end

local setup_plug = function()
  local path = vim.fn.stdpath('config') .. '/plugged'
  require('vim-plug')(path)
end

function M.setup()
  vim.schedule(set_window_options)

  remap_leader_key()
  setup_syntax_and_filetype()
  set_global_options()
  set_global_vars()
  setup_global_mappings()

  setup_python()
  setup_plug()

  if loop.os_getenv('NVIM_BOOTSTRAP') then return end

  vim.schedule(require('lc').setup)
  require('plugins').setup_async()
end

return M
