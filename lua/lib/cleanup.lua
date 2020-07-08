local vcmd = vim.cmd

local cbs = {}

local M = {}

function M.register(fn)
  table.insert(cbs, fn)
end

function M.cleanup()
  local finished = 0
  for _, cb in pairs(cbs) do
    vim.schedule(function()
      cb()
      finished = finished + 1
    end)
  end

  vim.wait(500, function()
    return finished == #cbs
  end, 25)
end

function M.setup()
  vcmd([[augroup lua_lib_cleanup]])
  vcmd([[autocmd!]])
  vcmd([[autocmd VimLeavePre * lua require('lib.cleanup').cleanup()]])
  vcmd([[augroup END]])
end

return M
