"Using Django and Python file type instead of just Python
autocmd FileType python set ft=python.django

autocmd FileType python setlocal expandtab
autocmd FileType rst setlocal expandtab

autocmd BufWritePost *.py call Flake8()
autocmd BufReadPost *.py call Flake8()

inoremap # X#

"python-flake8 settings
let g:flake8_max_complexity=8
