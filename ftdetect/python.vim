autocmd FileType python setlocal shiftwidth=4 showtabline=4 expandtab
autocmd FileType rst setlocal shiftwidth=4 showtabline=4 expandtab

inoremap # X#

"python-flake8 settings
let g:flake8_max_complexity=16
let g:flake8_max_line_length=119
