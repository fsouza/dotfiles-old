local vcmd = vim.cmd
local vfn = vim.fn

vcmd('packadd packer.nvim')

local M = {}

local deps = {
  {'wbthomason/packer.nvim'; opt = true};
  {'godlygeek/tabular'; opt = true; cmd = {'Tabularize'}};
  {'junegunn/fzf.vim'; opt = true; cmd = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'}};
  {'justinmk/vim-dirvish'};
  {
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
  };
  {'neovim/nvim-lspconfig'; opt = true};
  {'nvim-lua/completion-nvim'; opt = true};
  {'sheerun/vim-polyglot'; opt = true; ft = {'javascript'; 'lua'; 'python'; 'typescript'}};
  {
    'tpope/vim-commentary';
    opt = true;
    keys = {{'n'; 'gcc'}; {'x'; 'gc'}; {'o'; 'gc'}; {'n'; 'gc'}};
  };
  {'tpope/vim-repeat'};
  {
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
  };
  {
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
  };
  {'rhysd/git-messenger.vim'; opt = true; cmd = {'GitMessenger'}; keys = {'<leader>gm'}};
  {'norcalli/nvim-colorizer.lua'};
  {'kana/vim-textobj-user'};
  {
    'thinca/vim-textobj-between';
    opt = true;
    keys = {{'x'; 'if'}; {'x'; 'af'}; {'o'; 'if'}; {'o'; 'af'}};
  };
  {'nvim-treesitter/nvim-treesitter'; opt = true};
  {'nvim-treesitter/nvim-treesitter-textobjects'; opt = true};
  {'nvim-treesitter/playground'; opt = true; cmd = {'TSPlaygroundToggle'}};
  {'romgrk/nvim-treesitter-context'; opt = true; cmd = {'TSContextEnable'}};
  {
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
  };
}

function M.reload()
  package.loaded['packed'] = nil
  require('packed').setup(true)
  require('packer').sync()
end

local setup_auto_commands = function()
  local helpers = require('lib.nvim_helpers')
  local fpath = vfn.stdpath('config') .. '/lua/packed.lua'
  helpers.augroup('packer-auto-sync', {
    {events = {'BufWritePost'}; targets = {fpath}; command = [[lua require('packed').reload()]]};
  })
end

function M.setup(reloading)
  require('packer').startup({deps; config = {compile_on_sync = true}})
  setup_auto_commands()
  if not reloading then
    vim.schedule(function()
      vcmd([[doautocmd User PluginReady]])
    end)
  end
end

return M
