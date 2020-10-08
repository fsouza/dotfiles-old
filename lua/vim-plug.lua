local vcmd = vim.cmd
local vfn = vim.fn

local plugins = {
  {repo = 'godlygeek/tabular'; opts = {on = 'Tabularize'}}; {
    repo = 'junegunn/fzf.vim';
    opts = {as = 'fzf.vim'; on = {'FzfFiles'; 'FzfCommands'; 'FzfBuffers'; 'FzfLines'}};
  }; {repo = 'justinmk/vim-dirvish'};
  {repo = 'justinmk/vim-sneak'; opts = {on = {'<Plug>Sneak_s'; '<Plug>Sneak_;'; '<Plug>Sneak_,'}}};
  {repo = 'michaeljsmith/vim-indent-object'};
  {repo = 'neovim/nvim-lspconfig'; opts = {as = 'nvim-lspconfig'}; eager = true};
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
  }; {
    repo = 'mattn/emmet-vim';
    opts = {
      on = {
        'Emmet'; 'EmmetInstall'; '<Plug>(emmet-merge-lines)'; '<Plug>(emmet-anchorize-summary)';
        '<Plug>(emmet-anchorize-url)'; '<Plug>(emmet-remove-tag)'; '<Plug>(emmet-split-join-tag)';
        '<Plug>(emmet-toggle-comment)'; '<Plug>(emmet-image-encode)'; '<Plug>(emmet-image-size)';
        '<Plug>(emmet-move-prev)'; '<Plug>(emmet-move-next)'; '<Plug>(emmet-balance-tag-outword)';
        '<Plug>(emmet-balance-tag-inward)'; '<Plug>(emmet-update-tag)';
        '<Plug>(emmet-expand-word)'; '<Plug>(emmet-expand-abbr)'; '<Plug>(emmet-code-pretty)';
      };
    };
  };
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
      {lhs = '<C-Y>,'; rhs = '<Plug>(emmet-expand-abbr)'};
      {lhs = '<C-Y>D'; rhs = '<Plug>(emmet-balance-tag-outword)'};
      {lhs = '<C-Y>d'; rhs = '<Plug>(emmet-balance-tag-inward)'};
    };
    i = {
      {lhs = '<C-Y>m'; rhs = '<Plug>(emmet-merge-lines)'};
      {lhs = '<C-Y>A'; rhs = '<Plug>(emmet-anchorize-summary)'};
      {lhs = '<C-Y>a'; rhs = '<Plug>(emmet-anchorize-url)'};
      {lhs = '<C-Y>k'; rhs = '<Plug>(emmet-remove-tag)'};
      {lhs = '<C-Y>j'; rhs = '<Plug>(emmet-split-join-tag)'};
      {lhs = '<C-Y>/'; rhs = '<Plug>(emmet-toggle-comment)'};
      {lhs = '<C-Y>I'; rhs = '<Plug>(emmet-image-encode)'};
      {lhs = '<C-Y>i'; rhs = '<Plug>(emmet-image-size)'};
      {lhs = '<C-Y>N'; rhs = '<Plug>(emmet-move-prev)'};
      {lhs = '<C-Y>n'; rhs = '<Plug>(emmet-move-next)'};
      {lhs = '<C-Y>D'; rhs = '<Plug>(emmet-balance-tag-outword)'};
      {lhs = '<C-Y>d'; rhs = '<Plug>(emmet-balance-tag-inward)'};
      {lhs = '<C-Y>u'; rhs = '<Plug>(emmet-update-tag)'};
      {lhs = '<C-Y>;'; rhs = '<Plug>(emmet-expand-word)'};
      {lhs = '<C-Y>,'; rhs = '<Plug>(emmet-expand-abbr)'};
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
