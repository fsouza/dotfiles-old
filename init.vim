let $VIMHOME = expand('~/.config/nvim')
if !isdirectory($VIMHOME)
	let $VIMHOME = expand('~/.vim')
endif

if isdirectory($VIRTUALENVS)
	let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
	let g:python3_host_skip_check = 1
endif

call plug#begin($VIMHOME.'/plugged')
Plug 'artur-shaik/vim-javacomplete2'
Plug 'davidhalter/jedi-vim'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'fsouza/chapel.vim'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'idanarye/vim-dutyl', { 'branch': 'develop' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-grepper'
Plug 'mxw/vim-jsx'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'PProvost/vim-ps1'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'quramy/tsuquyomi'
Plug 'racer-rust/vim-racer'
Plug 'Rip-Rip/clang_complete'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'sirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sjbach/lusty'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

set t_Co=256
syntax on

if $ITERM_PROFILE =~ "talk"
	colorscheme default
else
	colorscheme none
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
set guicursor=
set mouse=a
set synmaxcol=160

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

let g:jsx_ext_required = 0

nmap <silent> <leader>g :Grepper -tool rg<CR>

autocmd FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T

let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
