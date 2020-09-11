local vcmd = vim.cmd
local vfn = vim.fn

local plugins = {
  {repo = 'godlygeek/tabular'; opts = {on = 'Tabularize'}}; {
    repo = 'junegunn/fzf.vim';
    opts = {as = 'fzf.vim'; on = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'}};
  }; {repo = 'justinmk/vim-dirvish'};
  {repo = 'justinmk/vim-sneak'; opts = {on = {'<Plug>Sneak_s'; '<Plug>Sneak_;'; '<Plug>Sneak_,'}}};
  {repo = 'michaeljsmith/vim-indent-object'};
  {repo = 'neovim/nvim-lspconfig'; opts = {as = 'nvim-lsp'}; eager = true};
  {repo = 'nvim-lua/completion-nvim'}; {repo = 'sheerun/vim-polyglot'};
  {repo = 'tpope/vim-commentary'; opts = {on = {'<Plug>CommentaryLine'; '<Plug>Commentary'}}};
  {repo = 'tpope/vim-repeat'}; {
    repo = 'tpope/vim-surround';
    opts = {
      on = {
        '<Plug>Dsurround'; '<Plug>Csurround'; '<Plug>CSurround'; '<Plug>Ysurround';
        '<Plug>YSurround'; '<Plug>Yssurround'; '<Plug>YSsurround'; '<Plug>VSurround';
        '<Plug>VgSurround';
      };
    };
  }; {repo = 'NLKNguyen/papercolor-theme'}; {repo = 'morhetz/gruvbox'};
  {repo = 'ChicoCodes/filewatch.nvim'; opts = {branch = 'main'}};
  {repo = 'flazz/vim-colorschemes'};
}

-- manually setup some mappings so lazy loading can work.
local manual_mappings = function()
  local helpers = require('lib.nvim_helpers')
  local vim_commentary = {lhs = 'gc'; rhs = '<Plug>Commentary'}
  local sneak_common = {{lhs = ';'; rhs = '<Plug>Sneak_;'}; {lhs = ','; rhs = '<Plug>Sneak_,'}};
  local mappings = {
    n = {
      vim_commentary; {lhs = 'gcc'; rhs = '<Plug>CommentaryLine'};
      {lhs = 'gS'; rhs = '<Plug>VgSurround'}; {lhs = 'ds'; rhs = '<Plug>Dsurround'};
      {lhs = 'cs'; rhs = '<Plug>Csurround'}; {lhs = 'cS'; rhs = '<Plug>CSurround'};
      {lhs = 'ys'; rhs = '<Plug>Ysurround'}; {lhs = 'yS'; rhs = '<Plug>YSurround'};
      {lhs = 'yss'; rhs = '<Plug>Yssurround'}; {lhs = 'ySs'; rhs = '<Plug>YSsurround'};
      {lhs = 's'; rhs = '<Plug>Sneak_s'}; {lhs = 'S'; rhs = '<Plug>Sneak_s'};
    };
    o = {vim_commentary; {lhs = 'z'; rhs = '<Plug>Sneak_s'}; {lhs = 'Z'; rhs = '<Plug>Sneak_s'}};
    x = {
      vim_commentary; {lhs = 'S'; rhs = '<Plug>VSurround'}; {lhs = 'gS'; rhs = '<Plug>VgSurround'};
    };
  }

  for _, entry in pairs(sneak_common) do
    table.insert(mappings.n, entry)
    table.insert(mappings.o, entry)
    table.insert(mappings.x, entry)
  end

  helpers.create_mappings(mappings)
end

do
  local path = vfn.stdpath('cache') .. '/vim-plug'
  local empty_dict = vim.empty_dict()

  vfn['plug#begin'](path)
  local plug = vfn['plug#']
  local load = vfn['plug#load']
  for _, plugin in pairs(plugins) do
    plug(plugin.repo, plugin.opts or empty_dict)
    if plugin.eager and plugin.opts and plugin.opts.as then
      load(plugin.opts.as)
    end
  end
  vfn['plug#end']()

  vim.schedule(function()
    manual_mappings()
    vcmd([[doautocmd User PluginReady]])
  end)
end
