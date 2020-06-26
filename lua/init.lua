local api = vim.api
local nvim_set_keymap = api.nvim_set_keymap
local loop = vim.loop
local vcmd = vim.cmd
local vfn = vim.fn

local helpers = require('lib.nvim_helpers')

local initial_mappings = function()
  -- Disable ex mode. I'm not that smart.
  nvim_set_keymap('n', 'Q', '', {})

  -- Remap the leader key.
  nvim_set_keymap('n', '<Space>', '', {})
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Remap jj
  nvim_set_keymap('i', 'jj', '<esc>', {})
  nvim_set_keymap('t', 'jj', [[<c-\><c-n>]], {})
end

local py3_host_prog = function()
  local vim_venv_bin = vfn.stdpath('cache') .. '/venv/bin'
  loop.os_setenv('PATH', vim_venv_bin .. ':' .. loop.os_getenv('PATH'))

  vim.g.python3_host_prog = vim_venv_bin .. '/python'
  vim.g.python3_host_skip_check = true
end

local hererocks = function()
  local lua_version = string.gsub(_VERSION, 'Lua ', '')
  local hererocks_path = vfn.stdpath('cache') .. '/hr'
  local bin_path = hererocks_path .. '/bin'
  local share_path = hererocks_path .. '/share/lua/' .. lua_version
  local lib_path = hererocks_path .. '/lib/lua/' .. lua_version
  package.path = package.path .. ';' .. share_path .. '/?.lua' .. ';' .. share_path ..
                   '/?/init.lua'
  package.cpath = package.cpath .. ';' .. lib_path .. '?.so'

  loop.os_setenv('PATH', bin_path .. ':' .. loop.os_getenv('PATH'))
end

local global_vars = function()
  vim.g.netrw_home = vfn.stdpath('data')
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
end

local ui_options = function()
  vim.o.termguicolors = true
  vim.o.showcmd = false
  vim.o.laststatus = 0
  vim.o.ruler = true
  vim.o.rulerformat = [[%-14.(%l,%c   %o%)]]
  vim.o.guicursor = ''
  vim.o.mouse = ''
  vim.o.shortmess = 'filnxtToOFIc'
  require('color').setup()
end

local global_options = function()
  vim.o.completeopt = 'menuone,noinsert,noselect'
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
  vim.o.inccommand = 'split'
  vim.o.timeoutlen = 500
end

local config_column = function()
  vim.wo.relativenumber = vim.bo.modifiable
  vim.wo.signcolumn = vim.bo.modifiable and 'yes' or 'auto'
  vim.schedule(function()
    vcmd([[augroup auto_rnu]])
    vcmd([[autocmd!]])
    vcmd(
      [[autocmd BufEnter * if &modifiable|setlocal relativenumber signcolumn=yes|else|setlocal norelativenumber signcolumn=auto|endif]])
    vcmd(
      [[autocmd WinNew * if &modifiable|setlocal relativenumber signcolumn=yes|else|setlocal norelativenumber signcolumn=auto|endif]])
    vcmd([[augroup END]])
  end)
end

local folding = function()
  vim.o.foldlevelstart = 99
  vim.wo.foldmethod = 'syntax'
  vim.schedule(function()
    vcmd([[augroup folding_config]])
    vcmd([[autocmd!]])
    vcmd([[autocmd BufEnter * setlocal foldmethod=syntax]])
    vcmd([[augroup END]])
  end)
end

local global_mappings = function()
  local rl_bindings = {
    {lhs = '<c-a>'; rhs = '<home>'; opts = {noremap = true}};
    {lhs = '<c-e>'; rhs = '<end>'; opts = {noremap = true}};
    {lhs = '<c-f>'; rhs = '<right>'; opts = {noremap = true}};
    {lhs = '<c-b>'; rhs = '<left>'; opts = {noremap = true}};
    {lhs = '<c-p>'; rhs = '<up>'; opts = {noremap = true}};
    {lhs = '<c-n>'; rhs = '<down>'; opts = {noremap = true}};
    {lhs = '<c-d>'; rhs = '<del>'; opts = {noremap = true}};
  }
  local win_mov_keys = {'h'; 'j'; 'k'; 'l'; 'w'}
  local maps = {
    n = {{lhs = '<leader>o'; rhs = helpers.cmd_map('only')}};
    i = {
      {lhs = '<c-f>'; rhs = '<right>'; opts = {noremap = true}};
      {lhs = '<c-b>'; rhs = '<left>'; opts = {noremap = true}};
      {lhs = '<c-d>'; rhs = '<del>'; opts = {noremap = true}};
    };
    c = rl_bindings;
    o = rl_bindings;
  }

  for _, key in ipairs(win_mov_keys) do
    table.insert(maps.n, {lhs = '<leader>' .. key; rhs = helpers.cmd_map('wincmd ' .. key)})
  end
  helpers.create_mappings(maps)
end

do
  local schedule = vim.schedule
  initial_mappings()

  schedule(hererocks)
  schedule(function()
    global_options()
    global_mappings()
  end)

  ui_options()
  config_column()
  folding()
  global_vars()
  py3_host_prog()

  require('pack').setup()
  schedule(function()
    require('plugin.init')
  end)
end
