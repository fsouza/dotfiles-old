let $VIMHOME = $HOME."/.vim"
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

call pathogen#infect()
call pathogen#helptags()

if ($ITERM_PROFILE =~? '.*colored.*')
	syntax on
else
	syntax off
endif

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
let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"

let g:godef_split=2
let g:godef_same_file_in_same_window=1

nmap <silent> <leader>d <Plug>DashSearch
