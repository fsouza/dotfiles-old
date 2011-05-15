set term=builtin_ansi

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$HOME."/.vim/python"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

"Syntax
syntax on

"Hidden mode
set hidden

"Setting up tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabpagemax=20
set showtabline=4
set smarttab
set autoindent
set smartindent
set expandtab

"Change file type for ruby
autocmd FileType ruby set ft=ruby.ruby-rails.ruby-rspec.ruby-rails-rjs.ruby-shoulda

"Change tabs to 2 space on ruby files
autocmd BufEnter *.rb set tabstop=2
autocmd BufEnter *.rb set shiftwidth=2
autocmd BufEnter *.rb set softtabstop=2

"Undo the change
autocmd BufLeave *.rb set tabstop=4
autocmd BufLeave *.rb set shiftwidth=4
autocmd BufLeave *.rb set softtabstop=4

"Set noexpandtab to Makefiles, to use <tab> char instead of spaces
autocmd FileType make setlocal noexpandtab

"Set smartindent for Python files
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"Map to execute Python files
autocmd FileType python map <Leader>p :!python % <CR>

"Settings for mark BadWhitespaces in Python files
autocmd FileType python highlight BadWhitespace ctermbg=red guibg=red
autocmd FileType python match BadWhitespace /^\t\+/
autocmd FileType python match BadWhitespace /\s\+$/

"Pylint
autocmd FileType python compiler pylint
"To disable calling Pylint every time a buffer is saved put into .vimrc file
let g:pylint_onwrite = 0
"Displaying code rate calculated by Pylint can be avoided by setting
"let g:pylint_show_rate = 0
"Openning of QuickFix window can be disabled with
"let g:pylint_cwindow = 0
"Of course, standard :make command can be used as in case

"Using Django and Python file type instead of just Python
autocmd FileType python set ft=python.django

"Setting file type to htmldjango and html
autocmd FileType htmldjango set ft=htmljinja.htmldjango.html
autocmd FileType html set ft=htmljinja.htmldjango.html
autocmd FileType xhtml set ft=htmljinja.htmldjango.html

"Setting syntax to htmldjango and html
autocmd FileType htmldjango set syntax=htmljinja
autocmd FileType html set syntax=htmljinja
autocmd FileType xhtml set syntax=htmljinja

"Setting file type to PHP and HTML (snippets)
autocmd FileType php set ft=php.html

"Setting file type to eruby and html (snippets)
autocmd FileType eruby set ft=eruby.eruby-rails.html

"Displaying line numbers
set number

"Colorscheme
colorscheme railscasts

nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <C-t> :CommandT<CR>

nmap <C-x> :LustyFilesystemExplorer<CR>
nmap <C-c> :LustyFilesystemExplorerFromHere<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"Related files, useful in Django
"Open files related to a Django project or app, as views.py, models.py or settings.py
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

"Function used to open RelatedFile
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

"Surrounds for Django templates
autocmd FileType htmldjango let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
autocmd FileType htmldjango let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
autocmd FileType htmldjango let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
autocmd FileType htmldjango let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
autocmd FileType htmldjango let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

"guifont
set guifont=Monaco

"Indent on
filetype indent on
filetype plugin on

"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

"Markdown syntax
autocmd BufRead,BufNewFile *.mkd setfiletype markdown
autocmd BufRead,BufNewFile *.markdown setfiletype markdown
autocmd BufRead,BufNewFile *.md setfiletype markdown

"Cucumber syntax
autocmd BufRead,BufNewFile *.feature setfiletype cucumber
autocmd BufRead,BufNewFile *.feature setfiletype cucumber

"Moving lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
