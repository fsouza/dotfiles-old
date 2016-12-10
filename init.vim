let $VIMHOME = expand('~/.config/nvim')
let $PATH .= ':'.$VIRTUALENVS.'/vim/bin'

let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
let g:python3_host_skip_check = 1
let g:python_host_prog = g:python3_host_prog
let g:python_host_skip_check = 1

call plug#begin($VIMHOME.'/plugged')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'davidhalter/jedi-vim'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'fsouza/chapel.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'hashivim/vim-terraform'
Plug 'hynek/vim-python-pep8-indent'
Plug 'idanarye/vim-dutyl', { 'branch': 'develop' }
Plug 'jmcantrell/vim-virtualenv'
Plug 'mxw/vim-jsx'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'racer-rust/vim-racer'
Plug 'rizzatti/dash.vim'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sjbach/lusty'
Plug 'tell-k/vim-autopep8'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

set t_Co=256
syntax on
colorscheme boring

filetype plugin indent on

if !isdirectory($VIMHOME.'/swp')
	call mkdir($VIMHOME.'/swp', 'p')
endif
set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*

set completeopt=menu,longest
set hidden laststatus=0 noshowcmd ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable
set autoindent smartindent smarttab
set wildmenu wildmode=list:longest
set mouse=a

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

let g:jsx_ext_required = 0

nmap <silent> <leader>D <Plug>DashSearch
