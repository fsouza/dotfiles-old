local vcmd = vim.cmd
local trigger_completion = vim.fn['completion#trigger_completion']

return function()
  vim.g.completion_enable_auto_popup = 1
  vcmd([[augroup nvim_complete_switch_off]])
  vcmd([[autocmd!]])
  vcmd([[autocmd InsertLeave <buffer> let g:completion_enable_auto_popup = 0]])
  vcmd([[augroup END]])
  return trigger_completion()
end
