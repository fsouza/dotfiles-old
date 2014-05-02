let $VIMHOME = $HOME."/.vim"
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

call pathogen#infect()

syntax off
filetype plugin on
filetype indent on

set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*""

set hidden
set ruler
set backspace=2
set nohlsearch
set nofoldenable

autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /\s\+$/

set autoindent
set smartindent
set smarttab
set nocompatible

set wildmenu
set wildmode=list:longest

function TrimWhiteSpace()
	let v = winsaveview()
	silent %s/\s\+$//
	call winrestview(v)
endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

set completeopt=menu,longest
let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_library_path = $HOME."/opt/lib"
