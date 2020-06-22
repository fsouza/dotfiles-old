local M = {}

local nvim_command = vim.api.nvim_command
local helpers = require('lib/nvim_helpers')

local add_fzf_to_runtimepath = function()
  local brew_prefix = vim.loop.os_getenv('HOMEBREW_PREFIX') or '/usr/local'
  local fzf_path = brew_prefix .. '/opt/fzf'
  nvim_command([[set runtimepath+=]] .. fzf_path)
end

local eager_pkgs = function()
  return {'nvim-lsp'; 'editorconfig-vim', 'vim-dirvish'}
end

local pkgs = function()
  return {
    'fzf-quickfix'; 'tabular'; 'fzf.vim'; 'vim-sneak'; 'typescript-vim';
    'vim-indent-object'; 'float-preview.nvim'; 'vim-ocaml'; 'deoplete.nvim'; 'deoplete-lsp';
    'ultisnips'; 'vim-commentary'; 'vim-fugitive'; 'vim-surround'; 'vim-python-pep8-indent';
  }
end

local syntax_and_filetype = function()
  helpers.exec_cmds({'syntax enable'; 'filetype plugin indent on'})
  vim.schedule(function()
    helpers.exec_cmds({
      [[match BadWhitespace /\s\+$/]]; [[autocmd BufEnter * match BadWhitespace /\s\+$/]];
    })
  end)
end

function M.setup()
  add_fzf_to_runtimepath()

  for _, pkg in ipairs(eager_pkgs()) do
    nvim_command('packadd! ' .. pkg)
  end

  vim.schedule(function()
    for _, pkg in ipairs(pkgs()) do
      nvim_command('packadd ' .. pkg)
    end

    syntax_and_filetype()
    nvim_command([[doautocmd User PluginReady]])
  end)
end

return M
