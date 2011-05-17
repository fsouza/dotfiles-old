set term=builtin_ansi

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$HOME."/.vim/python"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

syntax on
filetype indent on
filetype plugin on

"Hidden mode
set hidden
set number

"Setting up tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabpagemax=20
set showtabline=4
set autoindent
set expandtab
set smartindent
set smarttab

"Colorscheme
colorscheme moria

"guifont
set guifont=Monaco:h12

"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>

"Tabs navigation
nmap <C-Tab> gt
nmap <C-S-Tab> gT

"Command-T
nmap <C-t> :CommandT<CR>

"Lusty
nmap <C-x> :LustyFilesystemExplorer<CR>
nmap <C-c> :LustyFilesystemExplorerFromHere<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"Moving lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

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
