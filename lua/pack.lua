local M = {}

local vcmd = vim.cmd
local helpers = require('lib.nvim_helpers')

local pkgs = {
  'completion-nvim'; 'fzf.vim'; 'nvim-lsp'; 'tabular'; 'vim-commentary'; 'vim-dirvish';
  'vim-fugitive'; 'vim-indent-object'; 'vim-repeat'; 'vim-sneak'; 'vim-surround';
  'nvim-treesitter'; 'vista.vim'; 'completion-buffers'; 'vim-polyglot';
}

local syntax_and_filetype = function()
  helpers.exec_cmds({'syntax enable'; 'filetype plugin indent on'})
end

function M.setup()
  for _, pkg in ipairs(pkgs) do
    vcmd('packadd! ' .. pkg)
  end

  syntax_and_filetype()
  vim.schedule(function()
    vcmd([[doautocmd User PluginReady]])
  end)
end

return M
