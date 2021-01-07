local M = {}

local vfn = vim.fn

function M.fuzzy_here()
  require('findr').init(require('findr.sources.files'), vfn.expand('%:p:h'))
end

function M.rg(input)
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
