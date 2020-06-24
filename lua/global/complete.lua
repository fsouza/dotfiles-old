local nvim_command = vim.api.nvim_command
local deoplete_custom_option = vim.fn['deoplete#custom#option']
local deoplete_manual_complete = vim.fn['deoplete#manual_complete']

return function()
  deoplete_custom_option('auto_complete', true)
  nvim_command([[augroup deoplete_complete]])
  nvim_command([[autocmd!]])
  nvim_command(
    [[autocmd InsertLeave <buffer> call deoplete#custom#option('auto_complete', v:false)]])
  nvim_command([[augroup END]])
  return deoplete_manual_complete()
end
