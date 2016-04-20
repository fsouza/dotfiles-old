let $VIMHOME = $HOME."/.config/nvim"
let $PATH .= ":".$VIMHOME."/bundle/c-cpp-java-format.vim/bin"

let g:python3_host_prog = $VIRTUALENVS."/vim/bin/python"

call pathogen#infect()
call pathogen#helptags()

if ($ITERM_PROFILE =~? '.*color.*')
	syntax on
else
	syntax off
endif

filetype plugin on
filetype indent on

call mkdir($VIMHOME."/swp", "p")
set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*""

set hidden laststatus=0 noshowcmd ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable

set autoindent smartindent smarttab
set wildmenu wildmode=list:longest

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

set completeopt=menu,longest
let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1

let s:uname = substitute(system("uname -s"), "\n", "", "")
let s:osvimrc = $VIMHOME."/etc/".s:uname."-vimrc"
if filereadable(s:osvimrc)
	execute "source ".s:osvimrc
endif

if has("nvim")
	noremap <Leader>lf :Unite -smartcase file_rec/neovim<CR>
	noremap <Leader>lr :UniteWithBufferDir -smartcase file_rec/neovim<CR>
else
	noremap <Leader>lf :Unite -smartcase file_rec/ascync<CR>
	noremap <Leader>lr :UniteWithBufferDir -smartcase file_rec/async<CR>
end
noremap <Leader>lb :Unite -smartcase buffer<CR>

colorscheme boring
