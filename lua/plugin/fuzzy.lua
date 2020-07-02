local M = {}

local vfn = vim.fn

function M.rg(input)
  vfn['plug#load']('fzf.vim')
  input = input or vfn.input([[rg：]])
  if input ~= '' then
    local cmd =
      [[rg --column --line-number --hidden --no-heading --color=always --smart-case --glob '!.git' --glob '!.hg' -- ]] ..
        vfn.shellescape(input)
    vfn['fzf#vim#grep'](cmd, true, vfn['fzf#vim#with_preview']())
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
