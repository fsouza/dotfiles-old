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

autocmd FileType html set ft=htmldjango.html
autocmd FileType htmldjango set ft=htmldjango.html
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

let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \9 :e urls.py<cr>
nnoremap \0 :e settings.py<cr>

fun! RelatedFile(file)
    "This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()

