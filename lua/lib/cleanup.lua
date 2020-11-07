local fun = require('lib.fun_wrapper')
local helpers = require('lib.nvim_helpers')

local cbs = {}

local M = {}

function M.register(fn)
  table.insert(cbs, fn)
end

function M.cleanup()
  local finished = 0
  fun.safe_iter(cbs):each(function(cb)
    vim.schedule(function()
      cb()
      finished = finished + 1
    end)
  end)

  vim.wait(500, function()
    return finished == #cbs
  end, 25)
end

function M.setup()
  helpers.augroup('lua_lib_cleanup', {
    {events = {'VimLeavePre'}; targets = {'*'}; command = [[lua require('lib.cleanup')]]};
  })
end

return M
