local M = {}

local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local add_fzf_to_runtimepath = function()
  local brew_prefix = vim.loop.os_getenv('HOMEBREW_PREFIX') or '/usr/local'
  local fzf_path = brew_prefix .. '/opt/fzf'
  vcmd([[set runtimepath+=]] .. fzf_path)
end

local pkgs = function()
  return {
    'completion-nvim'; 'fzf.vim'; 'nvim-lsp'; 'tabular'; 'ultisnips'; 'vim-commentary';
    'vim-dirvish'; 'vim-fugitive'; 'vim-indent-object'; 'vim-repeat'; 'vim-sneak'; 'vim-snippets';
    'vim-surround'; 'nvim-treesitter'; 'vista.vim'; 'completion-buffers'; 'vim-polyglot';
  }
end

local syntax_and_filetype = function()
  helpers.exec_cmds({'syntax enable'; 'filetype plugin indent on'})
end

function M.setup()
  add_fzf_to_runtimepath()

  for _, pkg in ipairs(pkgs()) do
    vcmd('packadd! ' .. pkg)
  end

  vim.schedule(function()
    syntax_and_filetype()
    vcmd([[doautocmd User PluginReady]])
  end)
end

return M
