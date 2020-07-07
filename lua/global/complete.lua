local nvim_command = vim.api.nvim_command
local trigger_completion = vim.fn['completion#trigger_completion']

return function()
  vim.g.completion_enable_auto_popup = 1
  nvim_command([[augroup nvim_complete_switch_off]])
  nvim_command([[autocmd!]])
  nvim_command([[autocmd InsertLeave <buffer> let g:completion_enable_auto_popup = 0]])
  nvim_command([[augroup END]])
  return trigger_completion()
end
