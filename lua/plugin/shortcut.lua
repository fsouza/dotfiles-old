local vcmd = vim.cmd
local vfn = vim.fn

local M = {}

-- mode maybe s or t, where s means split (right) and t means tab.
local goto_dir = function(directory)
  vcmd([[belowright vsplit]])
  vcmd([[lcd ]] .. directory)
  vcmd('FzfFiles ' .. directory)
end

function M.vimfiles()
  goto_dir(vfn.stdpath('config'))
end

function M.dotfiles()
  goto_dir(vfn.expand('~/.dotfiles'))
end

return M
