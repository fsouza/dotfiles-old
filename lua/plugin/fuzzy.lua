local M = {}

local vfn = vim.fn
local nvim_command = vim.api.nvim_command

function M.rg(input)
  input = input or vfn.input([[rg\ ]])
  if input ~= '' then
    nvim_command(string.format([[FzfPreviewProjectGrep "%s"]], input))
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
