local M = {}

local vfn = vim.fn

function M.rg(input)
  input = input or vfn.input([[rg\ ]])
  if input ~= '' then
    local arg = vfn['fzf_preview#initializer#initialize']('s:project_grep', vim.empty_dict(), input)
    vfn['fzf_preview#runner#fzf_run'](arg)
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
