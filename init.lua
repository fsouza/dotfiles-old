local api = vim.api
local nvim_set_keymap = api.nvim_set_keymap
local vcmd = vim.cmd
local vfn = vim.fn

local cache_dir = vfn.stdpath('cache')
local data_dir = vfn.stdpath('data')

local helpers = require('fsouza.lib.nvim_helpers')

local function initial_mappings()
  -- Disable ex mode. I'm not that smart.
  nvim_set_keymap('n', 'Q', '', {})

  -- Remap the leader key.
  nvim_set_keymap('n', '<Space>', '', {})
  vim.g.mapleader = ' '

  -- <leader>w for writing (with update instead of 'write')
  nvim_set_keymap('n', '<leader>w', '<cmd>update<cr>', {})
end

local function bootstrap_env()
  local stdlib = require('posix.stdlib')
  stdlib.setenv('NVIM_CACHE_DIR', cache_dir)

  local vim_venv_bin = cache_dir .. '/venv/bin'
  local hererocks_bin = cache_dir .. '/hr/bin'
  local langservers_bin = cache_dir .. '/langservers/bin'

  stdlib.setenv('PATH', string.format('%s:%s:%s:%s', langservers_bin, hererocks_bin, vim_venv_bin,
                                      stdlib.getenv('PATH')))
end

local function hererocks()
  local lua_version = string.gsub(_VERSION, 'Lua ', '')
  local hererocks_path = cache_dir .. '/hr'
  local share_path = hererocks_path .. '/share/lua/' .. lua_version
  local lib_path = hererocks_path .. '/lib/lua/' .. lua_version
  package.path = package.path .. ';' .. share_path .. '/?.lua' .. ';' .. share_path ..
                   '/?/init.lua'
  package.cpath = package.cpath .. ';' .. lib_path .. '/?.so'
end

local function global_vars()
  vim.g.netrw_home = data_dir
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g.fzf_layout = {window = {width = 0.9; height = 0.6}}
  vim.g.polyglot_disabled = {'markdown'; 'sensible'; 'autoindent'}
  vim.g.user_emmet_mode = 'i'
  vim.g.user_emmet_leader_key = [[<C-x>]]
end

local function ui_options()
  vim.o.termguicolors = true
  vim.o.showcmd = false
  vim.o.laststatus = 0
  vim.o.ruler = true
  vim.o.rulerformat = [[%-14.(%l,%c   %o%)]]
  vim.o.guicursor = ''
  vim.o.mouse = ''
  vim.o.shortmess = 'filnxtToOFIc'
  require('fsouza.color').enable()
end

local function global_options()
  vim.o.completeopt = 'menuone,noinsert,noselect'
  vim.o.hidden = true
  vim.o.backspace = 'indent,eol,start'
  vim.o.hlsearch = false
  vim.o.incsearch = true
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
  vim.o.jumpoptions = 'stack'
end

local function rnu()
  vcmd('set relativenumber')
end

local function folding()
  local fold_method = 'indent'
  vim.o.foldlevelstart = 99
  vim.wo.foldmethod = fold_method
  vim.schedule(function()
    helpers.augroup('folding_config', {
      {events = {'BufEnter'}; targets = {'*'}; command = [[setlocal foldmethod=]] .. fold_method};
    })
  end)
end

local function global_mappings()
  local rl_bindings = {
    {lhs = '<c-a>'; rhs = '<home>'; opts = {noremap = true}};
    {lhs = '<c-e>'; rhs = '<end>'; opts = {noremap = true}};
    {lhs = '<c-f>'; rhs = '<right>'; opts = {noremap = true}};
    {lhs = '<c-b>'; rhs = '<left>'; opts = {noremap = true}};
    {lhs = '<c-p>'; rhs = '<up>'; opts = {noremap = true}};
    {lhs = '<c-n>'; rhs = '<down>'; opts = {noremap = true}};
    {lhs = '<c-d>'; rhs = '<del>'; opts = {noremap = true}};
  }
  local maps = {
    n = {
      {lhs = '<leader>o'; rhs = helpers.cmd_map('only')};
      {lhs = '<leader>O'; rhs = helpers.cmd_map('only') .. helpers.cmd_map('tabonly')};
      {
        lhs = 'j';
        rhs = [[(v:count > 8 ? "m'" . v:count : '') . 'j']];
        opts = {expr = true; noremap = true};
      };
      {
        lhs = 'k';
        rhs = [[(v:count > 8 ? "m'" . v:count : '') . 'k']];
        opts = {expr = true; noremap = true};
      };
    };
    i = {{lhs = '<c-d>'; rhs = '<del>'; opts = {noremap = true}}};
    c = rl_bindings;
    o = rl_bindings;
  }

  local win_mov_keys = {'h'; 'j'; 'k'; 'l'}
  for _, key in ipairs(win_mov_keys) do
    table.insert(maps.n, {lhs = '<leader>' .. key; rhs = helpers.cmd_map('wincmd ' .. key)})
  end
  helpers.create_mappings(maps)
end

do
  local schedule = vim.schedule
  initial_mappings()
  hererocks()
  bootstrap_env()

  schedule(function()
    global_options()
    global_mappings()
  end)

  ui_options()
  rnu()
  folding()
  global_vars()

  require('fsouza.packed').setup()
  if not os.getenv('NVIM_BOOTSTRAP') then
    schedule(function()
      require('fsouza.plugin')
    end)
  end
end
