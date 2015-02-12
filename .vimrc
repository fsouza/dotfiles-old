let $VIMHOME = $HOME."/.vim"
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

call pathogen#infect()
call pathogen#helptags()

syntax off
filetype plugin on
filetype indent on

set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*""

set hidden
set ruler
set rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2
set nohlsearch
set nofoldenable

set autoindent
set smartindent
set smarttab
set nocompatible

set wildmenu
set wildmode=list:longest

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

set completeopt=menu,longest
let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_library_path = $HOME."/opt/lib"
