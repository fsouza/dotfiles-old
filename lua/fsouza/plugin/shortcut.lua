local api = vim.api
local vcmd = vim.cmd

-- workaround for fzf loading issue. I should just switch to telescope.nvim.
local _ = vim.fn['fzf#run']

local M = {}

local fzf_dir = function(directory, cd)
  require('fsouza.plugin.fuzzy').ensure_fzf()
  if cd then
    api.nvim_set_current_dir(directory)
    vcmd('FzfFiles')
  else
    vcmd('FzfFiles ' .. directory)
  end
end

function M.register(command, path, cd)
  local is_dir_cb = function(is_dir)
    if is_dir then
      fzf_dir(path, cd)
    else
      vcmd('edit ' .. path)
    end
  end
  M[command] = function()
    require('fsouza.lib.fs').check_directory(path, vim.schedule_wrap(is_dir_cb))
  end
  vcmd(string.format([[command! %s lua require('fsouza.plugin.shortcut')['%s']()]], command,
                     command))
end

return M
