let g:autopep8_max_line_length=109
let g:autopep8_disable_show_diff=1

let g:pymode_rope_goto_definition_bind = 'gd'
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = ''
let g:pymode_options_max_line_length = 109
let g:pymode_lint_on_write = 0
let g:pymode_options = 0
let g:pymode_python = 'python3'

autocmd FileType python setlocal shiftwidth=4 expandtab
autocmd FileType python map <buffer> <Leader>f :call Autopep8()<CR>
autocmd FileType rst setlocal shiftwidth=4 expandtab

inoremap # X#
