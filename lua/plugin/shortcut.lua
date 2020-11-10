local api = vim.api
local vcmd = vim.cmd
local vfn = vim.fn

-- workaround for fzf loading issue. I should just switch to telescope.nvim.
local _ = vfn['fzf#run']

local M = {}

local fzf_dir = function(directory, cd)
  require('plugin.fuzzy').ensure_fzf()
  if cd then
    api.nvim_set_current_dir(directory)
    vcmd('FzfFiles')
  else
    vcmd('FzfFiles ' .. directory)
  end
end

function M.register(command, path, cd)
  M[command] = function()
    if vfn.isdirectory(path) == 1 then
      fzf_dir(path, cd)
    else
      vcmd('edit ' .. path)
    end
  end
  vcmd(string.format([[command! %s lua require('plugin.shortcut')['%s']()]], command, command))
end

function M.cd_git(file_path)
  local dir = require('nvim_lsp').util.search_ancestors(file_path, function(p)
    return vfn.isdirectory(p .. '/.git') == 1
  end)
  if dir then
    api.nvim_set_current_dir(dir)
  end
end

return M
