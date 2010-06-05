set term=builtin_ansi

syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set tabpagemax=20
set showtabline=2

autocmd BufRead *.rb set ft=ruby.ruby-rails.ruby-rspec.ruby-rails-rjs.ruby-shoulda

set smarttab
set autoindent
set smartindent
set expandtab

autocmd FileType make setlocal noexpandtab

autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python map <Leader>p :!python % <CR>
autocmd FileType python highlight BadWhitespace ctermbg=red guibg=red
autocmd FileType python match BadWhitespace /^\t\+/
autocmd FileType python match BadWhitespace /\s\+$/
autocmd FileType python set ft=python.django
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4

autocmd FileType html set ft=django_template.html
autocmd FileType php set ft=php.html
autocmd FileType eruby set ft=eruby.eruby-rails.html

set number
colorscheme railscasts

nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>
nmap ,t :tabnew<CR>
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <C-t> :CommandT<CR>
nmap <C-l> :!php -l %<CR>

map ,# :s/^/#/<CR>

map ,/ :s/^/\/\//<CR>

map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

