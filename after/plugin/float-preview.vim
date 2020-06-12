let g:float_preview#auto_close = 0

autocmd InsertLeave * if pumvisible() == 0|call float_preview#close()|endif
