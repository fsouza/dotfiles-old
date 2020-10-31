local api = vim.api
local vcmd = vim.cmd
local vfn = vim.fn

-- workaround for fzf loading issue. I should just switch to telescope.nvim.
local _ = vfn['fzf#run']

local M = {}

local fzf_dir = function(directory, cd)
  vfn['plug#load']('fzf.vim')
  if cd then
    api.nvim_set_current_dir(directory)
    vcmd('FzfFiles')
  else
    vcmd('FzfFiles ' .. directory)
  end
end

function M.register(command, directory, cd)
  M[command] = function()
    fzf_dir(directory, cd)
  end
  vcmd(string.format([[command! %s lua require('plugin.shortcut')['%s']()]], command, command))
end

return M
