local M = {}

function M.rg()
  local input = vim.fn.input([[rg \ ]])
  if input ~= '' then
    local cmd =
      [[rg --column --line-number --hidden --no-heading --color=always --smart-case --glob '!.git' --glob '!.hg' -- ]] ..
        vim.fn.shellescape(input)
    vim.fn['fzf#vim#grep'](cmd, true)
  end
end

return M
