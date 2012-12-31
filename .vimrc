"Setting VIMHOME
let $VIMHOME = $HOME."/.vim"

"Setting PATH
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

syntax off
filetype plugin on
filetype indent on

set directory=$VIMHOME/swp

"Hidden mode
set hidden
set ruler

"Backspace
set backspace=2

"Skip back for temp files
set backupskip=/tmp/*,/private/tmp/*""

"Bad whitespaces
autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /\s\+$/

"Setting up tab settings
set tabpagemax=20
set autoindent
set smartindent
set smarttab
set wildmenu
set wildmode=list:longest

"Start mappings
"==============
"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <S-f> :NERDTreeFind<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    let v = winsaveview()
    silent %s/\s\+$//
    call winrestview(v)
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

" Depends on Tabular.vim
vmap <F3> :Tabularize /\\$<CR>

"============
"End mappings

set completeopt=menu,longest
let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
