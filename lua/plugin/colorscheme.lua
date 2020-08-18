local vcmd = vim.cmd

local M = {}

function M.setup_filewatcher()
  local set_colorscheme = function(file_path)
    local file_handle, err = io.open(file_path, 'r')
    if err ~= nil then
      return
    end

    local content = file_handle:read('*all')
    file_handle:close()
    local parts = vim.split(content, ' ')
    if parts[1] ~= '' then
      pcall(function()
        vcmd(string.format('colorscheme %s', parts[1]))
      end)
    end
    if parts[2] == 'dark' or parts[2] == 'light' then
      vim.o.background = parts[2]
    end
  end
  local file_path = '/tmp/colorscheme.txt'
  set_colorscheme(file_path)
  M.stop_filewatcher = require('filewatch').watch(file_path, vim.schedule_wrap(set_colorscheme))
end

return M
