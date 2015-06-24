let $VIMHOME = $HOME."/.vim"
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

call pathogen#infect()
call pathogen#helptags()

syntax off
filetype plugin on
filetype indent on

set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*""

set hidden ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch nofoldenable

set autoindent smartindent smarttab
set nocompatible

set wildmenu wildmode=list:longest

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

set completeopt=menu,longest

if $ITERM_PROFILE == "talk (colored)"
	syntax on
endif
