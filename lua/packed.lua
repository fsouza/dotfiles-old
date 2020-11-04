local vcmd = vim.cmd
local vfn = vim.fn

vcmd('packadd packer.nvim')

local M = {}

function M.reload()
  package.loaded['packed'] = nil
  require('packed')
  require('packer').sync()
end

local add_sync_commands = function()
  vcmd([[command! -bar PackerInstallSync lua require('packed').sync('install')]])
  vcmd([[command! -bar PackerUpdateSync lua require('packed').sync('update')]])
  vcmd([[command! -bar PackerSyncSync lua require('packed').sync('sync')]])
end

local setup_auto_commands = function()
  local helpers = require('lib.nvim_helpers')

  local fpath = vfn.stdpath('config') .. '/lua/packed.lua'
  helpers.augroup('packer-auto-sync', {
    {events = {'BufWritePost'}; targets = {fpath}; command = [[lua require('packed').reload()]]};
  })
end

local setup_packer = function(use)
  use({'wbthomason/packer.nvim'; opt = true})

  use({'godlygeek/tabular'; opt = true; cmd = {'Tabularize'}})
  use({'junegunn/fzf.vim'; opt = true; cmd = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'}})
  use({'justinmk/vim-dirvish'})
  use({
    'justinmk/vim-sneak';
    opt = true;
    keys = {
      {'n'; 's'};
      {'n'; 'S'};
      {'o'; 'z'};
      {'o'; 'Z'};
      {'n'; ';'};
      {'n'; ','};
      {'x'; ';'};
      {'x'; ','};
      {'o'; ';'};
      {'o'; ','};
    };
  });
  use({'neovim/nvim-lspconfig'})
  use({'nvim-lua/completion-nvim'; opt = true})
  use({'sheerun/vim-polyglot'})
  use({
    'tpope/vim-commentary';
    opt = true;
    keys = {{'n'; 'gcc'}; {'x'; 'gc'}; {'o'; 'gc'}; {'n'; 'gc'}};
  })
  use({'tpope/vim-repeat'})
  use({
    'tpope/vim-surround';
    opt = true;
    keys = {
      {'n'; 'gS'};
      {'n'; 'ds'};
      {'n'; 'cs'};
      {'n'; 'cS'};
      {'n'; 'ys'};
      {'n'; 'yS'};
      {'n'; 'yss'};
      {'n'; 'ySs'};
      {'x'; 'S'};
      {'x'; 'gS'};
    };
  })
  use({
    'mattn/emmet-vim';
    opt = true;
    keys = {
      {'i'; '<C-X>m'};
      {'i'; '<C-X>A'};
      {'i'; '<C-X>a'};
      {'i'; '<C-X>k'};
      {'i'; '<C-X>j'};
      {'i'; '<C-X>/'};
      {'i'; '<C-X>I'};
      {'i'; '<C-X>i'};
      {'i'; '<C-X>N'};
      {'i'; '<C-X>n'};
      {'i'; '<C-X>D'};
      {'i'; '<C-X>d'};
      {'i'; '<C-X>u'};
      {'i'; '<C-X>;'};
      {'i'; '<C-X>,'};
    };
    cmd = {'Emmet'; 'EmmetInstall'};
  })
  use({'rhysd/git-messenger.vim'; opt = true; cmd = {'GitMessenger'}; keys = {'<leader>gm'}})
  use({'norcalli/nvim-colorizer.lua'})
  use({'kana/vim-textobj-user'})
  use({
    'thinca/vim-textobj-between';
    opt = true;
    keys = {{'x'; 'if'}; {'x'; 'af'}; {'o'; 'if'}; {'o'; 'af'}};
  })
  use({'nvim-treesitter/nvim-treesitter'})
  use({'nvim-treesitter/nvim-treesitter-textobjects'})
  use({'nvim-treesitter/playground'; opt = true; cmd = {'TSPlaygroundToggle'}})
  use({'romgrk/nvim-treesitter-context'; opt = true; cmd = {'TSContextEnable'}})
  use({
    'michaeljsmith/vim-indent-object';
    opt = true;
    keys = {
      {'x'; 'ii'};
      {'x'; 'ai'};
      {'x'; 'iI'};
      {'x'; 'aI'};
      {'o'; 'ii'};
      {'o'; 'ai'};
      {'o'; 'iI'};
      {'o'; 'aI'};
    };
  })
end

function M.setup(reloading)
  require('packer').startup({
    setup_packer;
    config = {compile_on_sync = true; disable_commands = true};
  })
  add_sync_commands()
  setup_auto_commands()
  if not reloading then
    vim.schedule(function()
      vcmd([[doautocmd User PluginReady]])
    end)
  end
end

return M
