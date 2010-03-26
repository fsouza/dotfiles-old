set term=builtin_ansi
syntax on
autocmd BufRead *.py set cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py inoremap # X^H#
set tabstop=4
set smartindent
set autoindent
set shiftwidth=4
set smarttab
set expandtab
autocmd BufRead * set softtabstop=4
autocmd BufRead *.py set autoindent
autocmd BufRead *.py highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead *.py match BadWhitespace /^\t\+/
autocmd BufRead *.py match BadWhitespace /\s\+$/
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate"

colorscheme Dark
nmap <silent> <c-p> :NERDTreeToggle<CR>
nnoremap <c-o> :FufFile<CR>
nnoremap <c-l> :FufDir<CR>
