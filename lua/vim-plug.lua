local M = {}

local nvim_command = vim.api.nvim_command

local pkgs = function()
  local brew_prefix = vim.loop.os_getenv('HOMEBREW_PREFIX') or '/usr/local'

  return {
    {repo = 'editorconfig/editorconfig-vim'};
    {repo = 'fszymanski/fzf-quickfix'; opts = {on = 'FzfQuickfix'}}; {repo = 'godlygeek/tabular'};
    {repo = brew_prefix .. '/opt/fzf'}; {repo = 'junegunn/fzf.vim'};
    {repo = 'justinmk/vim-dirvish'}; {repo = 'justinmk/vim-sneak'};
    {repo = 'leafgarland/typescript-vim'; opts = {['for'] = 'typescript'}};
    {repo = 'michaeljsmith/vim-indent-object'};
    {repo = 'neovim/nvim-lsp'; opts = {['as'] = 'nvim-lsp'}; eager = true};
    {repo = 'ncm2/float-preview.nvim'}; {repo = 'ocaml/vim-ocaml'; opts = {['for'] = 'ocaml'}};
    {repo = 'Shougo/deoplete.nvim'; opts = {['do'] = ':UpdateRemotePlugins'}};
    {repo = 'Shougo/deoplete-lsp'}; {repo = 'SirVer/ultisnips'}; {repo = 'honza/vim-snippets'};
    {repo = 'tpope/vim-commentary'}; {repo = 'tpope/vim-fugitive'}; {repo = 'tpope/vim-repeat'};
    {repo = 'tpope/vim-surround'};
    {repo = 'Vimjas/vim-python-pep8-indent'; opts = {['for'] = 'python'}}
  }
end

function M.setup(path)
  local empty_dict = vim.empty_dict()
  vim.fn['plug#begin'](path)
  for _, args in ipairs(pkgs()) do
    vim.fn['plug#'](args.repo, args.opts or empty_dict)

    if args.eager and args.opts.as then
      vim.fn['plug#load'](args.opts.as)
    end
  end
  vim.fn['plug#end']()
  vim.schedule(function()
    nvim_command([[doautocmd User PluginReady]])
  end)
end

local vim_plug_cmd = function(cmd, exit_on_completion)
  nvim_command(cmd)
  if exit_on_completion then
    nvim_command('qa')
  end
end

function M.install(exit_on_completion)
  vim_plug_cmd('PlugInstall', exit_on_completion)
end

function M.update(exit_on_completion)
  vim_plug_cmd('PlugUpdate', exit_on_completion)
end

return M
