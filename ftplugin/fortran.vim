let fortran_free_source=1

setlocal textwidth=90
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
