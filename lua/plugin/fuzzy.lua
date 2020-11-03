local M = {}

local vcmd = vim.cmd
local vfn = vim.fn

function M.ensure_fzf()
  vcmd('packadd fzf.vim')
end

function M.fzf_here()
  M.ensure_fzf()
  vfn['fzf#vim#files'](vfn.expand('%:p:h'))
end

function M.rg(input)
  M.ensure_fzf()
  input = input or vfn.input([[rg：]])
  if input ~= '' then
    local cmd =
      [[rg --column -n --hidden --no-heading --color=always -S --glob '!.git' --glob '!.hg' -- ]] ..
        vfn.shellescape(input)
    vfn['fzf#vim#grep'](cmd, true, vfn['fzf#vim#with_preview']())
  end
end

function M.rg_cword()
  M.rg(vfn.expand('<cword>'))
end

return M
