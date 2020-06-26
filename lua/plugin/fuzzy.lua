local M = {}

local vfn = vim.fn
local vcmd = vim.cmd

function M.rg(input)
  input = input or vfn.input([[rg\ ]])
  if input ~= '' then
    vcmd(string.format([[FzfPreviewProjectGrep "%s"]], input))
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
