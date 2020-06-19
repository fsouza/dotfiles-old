local M = {}

function M.rg()
  local input = vim.fn.input([[rg \ ]])
  if input ~= '' then
    local cmd = 'rg --column --line-number --no-heading --color=always --smart-case -- ' ..
                  vim.fn.shellescape(input)
    vim.fn['fzf#vim#grep'](cmd, true)
  end
end

return M
