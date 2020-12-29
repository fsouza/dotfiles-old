local M = {}

local vcmd = vim.cmd
local vfn = vim.fn

function M.ensure_fzf()
  vcmd('packadd fzf.vim')
end

local function ensure_findr()
  vcmd('packadd findr.vim')
end

function M.fuzzy_here()
  ensure_findr()
  require('findr').init(require('findr.sources.files'), vfn.expand('%:p:h'))
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

function M.files()
  local cmd = 'FzfFiles'
  if vfn.isdirectory('.git') == 1 then
    cmd = 'FzfGitFiles'
  end
  vcmd(cmd)
end

return M
