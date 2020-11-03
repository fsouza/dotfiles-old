local vcmd = vim.cmd

vcmd('packadd packer.nvim')

local M = {}

local minute_ms = 60000

function M.sync(op, timeout_ms)
  local a = require('packer.async')
  local async = a.sync
  local done = false

  async(function()
    require('packer')[op]()
    done = true
  end)()

  timeout_ms = timeout_ms or (5 * minute_ms)
  vim.wait(timeout_ms, function()
    return done
  end, 50)
end

local add_sync_commands = function()
  vcmd([[command! -bar PackerInstallSync lua require('packed').sync('install')]])
  vcmd([[command! -bar PackerUpdateSync lua require('packed').sync('update')]])
  vcmd([[command! -bar PackerSyncSync lua require('packed').sync('sync')]])
end

do
  require('packer').startup(function(use)
    use({'wbthomason/packer.nvim'; opt = true})

    use({'godlygeek/tabular'; opt = true; cmd = {'Tabularize'}})
    use({
      'junegunn/fzf.vim';
      opt = true;
      cmd = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'};
    })
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
    use({'nvim-lua/completion-nvim'})
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
    use({'thinca/vim-textobj-between'})
    use({'nvim-treesitter/nvim-treesitter'})
    use({'nvim-treesitter/nvim-treesitter-textobjects'})
    use({'nvim-treesitter/playground'})
    use({'romgrk/nvim-treesitter-context'})
    use({'michaeljsmith/vim-indent-object'})
  end)
  add_sync_commands()
  vcmd([[doautocmd User PluginReady]])
end

return M
