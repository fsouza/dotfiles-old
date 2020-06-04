nnoremap <Space> <nop>
let mapleader = " "

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
Plug 'fsouza/hlyank.vim'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ocaml/vim-ocaml'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sjbach/lusty'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

set t_Co=256
syntax on
colorscheme none

filetype plugin indent on

call mkdir($VIMHOME.'/undo-dir', 'p')

set completeopt=menu,longest
set hidden noshowcmd
set laststatus=0
set ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable smartcase
set autoindent smartindent smarttab
set wildmenu wildmode=list:longest
set guicursor=
set mouse=
set shortmess=filnxtToOFI
set noerrorbells
set undodir=$VIMHOME/undo-dir
set nobackup noswapfile undofile

let g:netrw_banner = 0
let g:HlYank_delay_ms = 300

autocmd FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T
