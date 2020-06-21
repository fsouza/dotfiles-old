local M = {}

local nvim_command = vim.api.nvim_command

local add_fzf_to_runtimepath = function()
  local brew_prefix = vim.loop.os_getenv('HOMEBREW_PREFIX') or '/usr/local'
  local fzf_path = brew_prefix .. '/opt/fzf'
  nvim_command([[set runtimepath+=]] .. fzf_path)
end

local pkgs = function()
  return {
    'nvim-lsp'; 'editorconfig-vim'; 'fzf-quickfix'; 'tabular'; 'fzf.vim'; 'vim-dirvish';
    'vim-sneak'; 'typescript-vim'; 'vim-indent-object'; 'float-preview.nvim'; 'vim-ocaml';
    'deoplete.nvim'; 'deoplete-lsp'; 'ultisnips'; 'vim-commentary'; 'vim-fugitive'; 'vim-surround';
    'vim-python-pep8-indent';
  }
end

function M.setup()
  add_fzf_to_runtimepath()

  vim.schedule(function()
    for _, pkg in ipairs(pkgs()) do
      nvim_command('packadd ' .. pkg)
    end

    nvim_command([[doautocmd User PluginReady]])
  end)
end

return M
