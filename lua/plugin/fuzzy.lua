local M = {}

local vfn = vim.fn

function M.rg(input)
  input = input or vfn.input([[rg\ ]])
  if input ~= '' then
    local cmd =
      [[rg --column --line-number --hidden --no-heading --color=always --smart-case --glob '!.git' --glob '!.hg' -- ]] ..
        vfn.shellescape(input)
    vfn['fzf#vim#grep'](cmd, true)
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
