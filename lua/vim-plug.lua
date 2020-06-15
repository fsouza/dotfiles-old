local get_pkgs = function()
  local brew_prefix = vim.loop.os_getenv('HOMEBREW_PREFIX') or '/usr/local'

  return {
    { 'editorconfig/editorconfig-vim' };
    { 'fszymanski/fzf-quickfix'; { on = 'FzfQuickfix' }};
    { 'godlygeek/tabular' };
    { brew_prefix .. '/opt/fzf' };
    { 'junegunn/fzf.vim' };
    { 'justinmk/vim-dirvish' };
    { 'justinmk/vim-sneak' };
    { 'leafgarland/typescript-vim'; { ['for'] = 'typescript' } };
    { 'michaeljsmith/vim-indent-object' };
    { 'neovim/nvim-lsp'; { as = 'nvim-lsp' } };
    { 'ncm2/float-preview.nvim' };
    { 'ocaml/vim-ocaml'; { ['for'] = 'ocaml' }};
    { 'Shougo/deoplete.nvim'; { ['do'] = ':UpdateRemotePlugins' }};
    { 'Shougo/deoplete-lsp' };
    { 'SirVer/ultisnips' };
    { 'honza/vim-snippets' };
    { 'tpope/vim-commentary' };
    { 'tpope/vim-fugitive' };
    { 'tpope/vim-repeat' };
    { 'tpope/vim-surround' };
    { 'Vimjas/vim-python-pep8-indent'; { ['for'] = 'python' }};
  }
end

return function(path)
  vim.fn['plug#begin'](path)
  for _, args in ipairs(get_pkgs()) do
    vim.api.nvim_call_function('plug#', args)

    if args[2] and args[2].as then
      vim.api.nvim_call_function('plug#load', { args[2].as })
    end
  end
  vim.fn['plug#end']()
end
