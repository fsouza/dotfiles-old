nnoremap <Space> <nop>
let mapleader = ' '
let maplocalleader = ' '

let $VIMHOME = resolve(expand('<sfile>:p:h'))
let $PATH = $VIMHOME.'/bin:'.$PATH

if isdirectory($VIRTUALENVS)
	let $PATH = $VIRTUALENVS.'/vim/bin:'.$PATH
	let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
	let g:python3_host_skip_check = 1
endif

call plug#begin($VIMHOME.'/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'ncm2/float-preview.nvim'
Plug 'ocaml/vim-ocaml', { 'for': 'ocaml' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

if has('nvim')
	Plug 'neovim/nvim-lsp'
end
call plug#end()

set t_Co=256
syntax on
colorscheme none

filetype plugin indent on

call mkdir($VIMHOME.'/undo-dir', 'p')

set completeopt=menu,longest,noselect
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
let g:netrw_liststyle = 3

let g:float_preview#docked = 0

nnoremap <Up> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>

nnoremap <Leader>k <c-w>k
nnoremap <Leader>h <c-w>h
nnoremap <Leader>l <c-w>l
nnoremap <Leader>j <c-w>j
