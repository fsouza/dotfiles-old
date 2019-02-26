autocmd BufWritePost *.scala silent :EnTypeCheck
nnoremap <localleader>i :EnType<CR>
nnoremap gd :EnDeclaration<CR>
