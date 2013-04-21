autocmd FileType fortran setlocal expandtab shiftwidth=2 textwidth=90
let fortran_free_source=1
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1

vmap <F2> :Tabularize /::<CR>
