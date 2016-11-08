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
Plug 'idanarye/vim-dutyl'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mxw/vim-jsx'
Plug 'noah/vim256-color'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'racer-rust/vim-racer'
Plug 'rizzatti/dash.vim'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sjbach/lusty'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

set t_Co=256
syntax on
if ($ITERM_PROFILE =~ '.*color.*')
	colorscheme beauty256
else
	colorscheme boring
endif

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

set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

nmap <silent> <leader>D <Plug>DashSearch
