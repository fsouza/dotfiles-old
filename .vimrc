"Setting VIMHOME
let $VIMHOME = $HOME."/.vim"

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$VIMHOME."/python"

"Setting PATH
let $PATH .= ":".$VIMHOME."/python"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

syntax off
filetype indent on
filetype plugin on

"Hidden mode
set hidden
set number

"Backspace
set backspace=2

"linebreak
set wrap linebreak nolist

"Bad whitespaces
autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /^\t\+/
autocmd BufEnter * match BadWhitespace /\s\+$/

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
set wildmenu
set wildmode=list:longest

"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

"Start mappings
"==============
"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
    ''
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"Moving lines
noremap <C-j> :m+<CR>==
noremap <C-k> :m-2<CR>==
noremap <C-j> <Esc>:m+<CR>==gi
noremap <C-k> <Esc>:m-2<CR>==gi
noremap <C-j> :m'>+<CR>gv=gv
noremap <C-k> :m-2<CR>gv=gv

vnoremap <C-l> xp
vnoremap <C-h> xhP

"============
"End mappings
