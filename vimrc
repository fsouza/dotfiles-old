set term=builtin_ansi

syntax on
autocmd Filetype python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd Filetype python map <Leader>p :!python % <CR>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabpagemax=20
set showtabline=2

autocmd BufRead *.sql set tabstop=2
autocmd BufRead *.sql set shiftwidth=2
autocmd BufRead *.sql set softtabstop=2
autocmd BufRead *.rb set tabstop=2
autocmd BufRead *.rb set shiftwidth=2
autocmd BufRead *.rb set softtabstop=2
autocmd BufRead *.erb set tabstop=2
autocmd BufRead *.erb set shiftwidth=2
autocmd BufRead *.erb set softtabstop=2
autocmd BufRead *.rb set ft=ruby.ruby-rails.ruby-rspec.ruby-rails-rjs.ruby-shoulda
autocmd BufRead *.php set bomb

set smarttab
set autoindent
set smartindent
set expandtab

autocmd BufRead *.py set autoindent
autocmd BufRead *.py highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead *.py match BadWhitespace /^\t\+/
autocmd BufRead *.py match BadWhitespace /\s\+$/
autocmd FileType python set ft=python.django
autocmd FileType html set ft=django_template.html
autocmd BufRead *.erb set ft=eruby.eruby-rails.html
autocmd BufRead *.html.erb set ft=eruby.eruby-rails.html

set number

colorscheme Dark
nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>
nmap ,t :tabnew<CR>
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <C-t> :CommandT<CR>
nmap <C-l> :FufBuffer<CR>

map ,# :s/^/#/<CR>

map ,/ :s/^/\/\//<CR>

map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

