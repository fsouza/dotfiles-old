local vcmd = vim.cmd
local vfn = vim.fn

local M = {}

local deps = {
  {'akinsho/nvim-toggleterm.lua'};
  {'justinmk/vim-dirvish'};
  {'justinmk/vim-sneak'};
  {'kana/vim-textobj-user'};
  {'mg979/vim-visual-multi'};
  {'norcalli/nvim-colorizer.lua'};
  {'sheerun/vim-polyglot'};
  {'thinca/vim-textobj-between'};
  {'tpope/vim-repeat'};
  {'tpope/vim-surround'};

  {'wbthomason/packer.nvim'; opt = true};
  {'godlygeek/tabular'; opt = true; cmd = {'Tabularize'}};
  {'junegunn/fzf.vim'; opt = true; cmd = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'}};
  {'neovim/nvim-lspconfig'; opt = true};
  {'nvim-lua/completion-nvim'; opt = true};
  {
    'tpope/vim-commentary';
    opt = true;
    keys = {{'n'; 'gcc'}; {'x'; 'gc'}; {'o'; 'gc'}; {'n'; 'gc'}};
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
  {
    'nvim-treesitter/nvim-treesitter';
    opt = true;
    cmd = {
      'TSBufDisable';
      'TSDisableAll';
      'TSInstallFromGrammar';
      'TSModuleInfo';
      'TSBufEnable';
      'TSEnableAll';
      'TSInstallInfo';
      'TSPlaygroundToggle';
      'TSUninstall';
      'TSConfigInfo';
      'TSInstall';
      'TSInstallSync';
      'TSUpdate';
    };
  };
  {
    'nvim-treesitter/nvim-treesitter-textobjects';
    opt = true;
    cmd = {
      'TSTextobjectGotoNextEnd';
      'TSTextobjectGotoNextStart';
      'TSTextobjectGotoPreviousEnd';
      'TSTextobjectGotoPreviousStart';
      'TSTextobjectPeekDefinitionCode';
      'TSTextobjectSelect';
      'TSTextobjectSwapNext';
      'TSTextobjectSwapPrevious';
    };
  };
  {'nvim-treesitter/playground'; opt = true; cmd = {'TSPlaygroundToggle'}};
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
  {'tpope/vim-fugitive'; opt = true; cmd = {'Git'; 'GBrowse'}};
  {'szw/vim-maximizer'; opt = true; cmd = {'MaximizerToggle'}};
  {
    'conweller/findr.vim';
    opt = true;
    cmd = {'Findr'; 'FindrBuffers'; 'FindrLocList'; 'FindrQFList'};
  };
}

function M.reload()
  package.loaded['fsouza.packed'] = nil
  require('fsouza.packed').setup(true)
  require('packer').sync()
end

local function setup_auto_commands()
  local helpers = require('fsouza.lib.nvim_helpers')
  local fpath = vfn.stdpath('config') .. '/lua/fsouza/packed.lua'
  helpers.augroup('packer-auto-sync', {
    {
      events = {'BufWritePost'};
      targets = {fpath};
      command = [[lua require('fsouza.packed').reload()]];
    };
  })
end

local function packer_startup()
  vcmd('packadd packer.nvim')
  local compile_path = vfn.stdpath('data') .. '/site/plugin/packer_compiled.vim'
  require('packer').startup({
    deps;
    config = {
      compile_on_sync = true;
      compile_path = compile_path;
      display = {non_interactive = true};
    };
  })
end

local function basic_setup()
  setup_auto_commands()
  vcmd([[doautocmd User PackerReady]])
end

function M.setup(force_bootstrap)
  local bootstrap = force_bootstrap or os.getenv('NVIM_BOOTSTRAP')
  if bootstrap then
    packer_startup()
  end
  if not os.getenv('NVIM_BOOTSTRAP') then
    vim.schedule(basic_setup)
  end
end

return M
