set term=builtin_ansi
syntax on
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py inoremap # X^H#
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd BufRead *.rb set tabstop=2
autocmd BufRead *.rb set shiftwidth=2
autocmd BufRead *.rb set softtabstop=2
set smarttab
set autoindent
set smartindent
set expandtab
autocmd BufRead *.py set autoindent
autocmd BufRead *.py highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead *.py match BadWhitespace /^\t\+/
autocmd BufRead *.py match BadWhitespace /\s\+$/
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate"
autocmd FileType erb set ft=eruby.eruby-rails.html
set number

colorscheme Dark
nmap <silent> <c-p> :NERDTreeToggle<CR>
nnoremap <c-o> :FufFile<CR>
nnoremap <c-l> :FufDir<CR>
