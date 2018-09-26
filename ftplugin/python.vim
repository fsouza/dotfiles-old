autocmd BufWritePre *.py execute ':Black'

map <buffer> <Leader>f :Black<CR>
setlocal omnifunc=jedi#complete
setlocal completeopt-=preview
