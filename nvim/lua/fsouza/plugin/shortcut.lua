local api = vim.api
local vcmd = vim.cmd

-- workaround for fzf loading issue. I should just switch to telescope.nvim.
local _ = vim.fn['fzf#run']

local M = {}

local function fzf_dir(directory, cd)
  if cd then
    api.nvim_set_current_dir(directory)
    vcmd('FzfFiles')
  else
    vcmd('FzfFiles ' .. directory)
  end
end

function M.register(command, path, cd)
  local function is_dir_cb(is_dir)
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
