let $VIMHOME = expand('~/.config/nvim')
if !isdirectory($VIMHOME)
	let $VIMHOME = expand('~/.vim')
endif

if isdirectory($VIRTUALENVS)
	let $PATH = $VIRTUALENVS.'/vim/bin:'.$PATH
	let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
	let g:python3_host_skip_check = 1
endif

call plug#begin($VIMHOME.'/plugged')
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'google/vim-jsonnet'
Plug 'hashivim/vim-terraform'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-grepper'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rgrinberg/vim-ocaml'
Plug 'sjbach/lusty'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

set t_Co=256
syntax on
colorscheme none

filetype plugin indent on

call mkdir($VIMHOME.'/swp', 'p')
set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*

set completeopt=menu,longest
set hidden laststatus=0 noshowcmd ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable
set autoindent smartindent smarttab
set wildmenu wildmode=list:longest
set guicursor=
set mouse=a

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

let g:netrw_banner = 0

nmap <silent> <leader>g :Grepper -tool rg<CR>

autocmd FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T
