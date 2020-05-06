let $VIMHOME = expand('~/.config/nvim')
if !isdirectory($VIMHOME)
	let $VIMHOME = expand('~/.vim')
endif

let $PATH = $VIMHOME.'/bin:'.$PATH
if isdirectory($VIRTUALENVS)
	let $PATH = $VIRTUALENVS.'/vim/bin:'.$PATH
	let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
	let g:python3_host_skip_check = 1
endif

call plug#begin($VIMHOME.'/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'fsouza/coc.nvim', {'do': 'npx yarn install --frozen-lockfile'}
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'michaeljsmith/vim-indent-object'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ocaml/vim-ocaml'
Plug 'sjbach/lusty'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'

" coc extensions
Plug 'neoclide/coc-json', {'do': 'npx yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'npx yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'npx yarn install --frozen-lockfile'}
call plug#end()

set t_Co=256
syntax on
colorscheme none

filetype plugin indent on

call mkdir($VIMHOME.'/swp', 'p')
set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*

set completeopt=menu,longest
set hidden noshowcmd
set laststatus=0
set ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable
set autoindent smartindent smarttab
set wildmenu wildmode=list:longest
set guicursor=
set mouse=
set shortmess=filnxtToOFI

let g:netrw_banner = 0

autocmd FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T
