local M = {}

local vcmd = vim.cmd
local vfn = vim.fn
local loop = vim.loop

local run_in_terminal = function(wd, cmd)
  -- Use vfn.termopen() instead?
  vcmd(string.format('belowright split | resize 20 | lcd %s | term %s', wd, cmd))
end

function M.terminal_cmd(wd, cmd)
  if wd == nil then
    wd = loop.cwd()
  end
  if cmd == nil then
    cmd = vfn.input('＞ ')
  end
  run_in_terminal(wd, cmd)
end

function M.terminal_here(cmd)
  M.terminal_cmd(vfn.expand('%:h'), cmd)
end

return M
