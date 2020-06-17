return function()
  vim.fn['deoplete#custom#option']('auto_complete', true)
  vim.api.nvim_command(
    [[autocmd InsertLeave <buffer> call deoplete#custom#option('auto_complete', v:false)]])
  return vim.fn['deoplete#manual_complete']()
end
