autocmd FileType python setlocal shiftwidth=4 showtabline=4 expandtab
autocmd FileType python map <buffer> <Leader>f :call Autopep8()<CR>
autocmd FileType rst setlocal shiftwidth=4 showtabline=4 expandtab

let g:autopep8_max_line_length=109
let g:autopep8_disable_show_diff=1

inoremap # X#
