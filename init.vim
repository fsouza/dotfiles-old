let $VIMHOME = expand('~/.config/nvim')
let $PATH .= ':'.$VIMHOME.'/plugged/c-cpp-java-format.vim/bin'

let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
let g:python3_host_skip_check = 1

call plug#begin($VIMHOME.'/plugged')
Plug 'tpope/vim-surround'
Plug 'Rip-Rip/clang_complete'
Plug 'nvie/vim-flake8'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tpope/vim-dispatch'
Plug 'tell-k/vim-autopep8'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'rodjek/vim-puppet'
Plug 'markcornick/vim-terraform'
Plug 'guns/vim-clojure-static'
Plug 'derekwyatt/vim-scala'
Plug 'mattn/emmet-vim'
Plug 'moll/vim-node'
Plug 'fatih/vim-go'
Plug 'Shougo/unite.vim'
Plug 'rhysd/vim-go-impl'
Plug 'mhinz/vim-grepper'
Plug 'fsouza/chapel.vim'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun'
call plug#end()

syntax on
if ($ITERM_PROFILE !~ '.*color.*')
	colorscheme boring
endif

filetype plugin indent on

call mkdir($VIMHOME.'/swp', 'p')
set directory=$VIMHOME/swp
set backupskip=/tmp/*,/private/tmp/*

set completeopt=menu,longest
set hidden laststatus=0 noshowcmd ruler rulerformat=%-14.(%l,%c\ \ \ %o%)
set backspace=2 nohlsearch noincsearch nofoldenable
set autoindent smartindent smarttab
set wildmenu wildmode=list:longest

let s:uname = substitute(system('uname -s'), '\n', '', '')
let s:osvimrc = $VIMHOME.'/etc/'.s:uname.'.vim'
if filereadable(s:osvimrc)
	execute 'source '.s:osvimrc
endif

vmap <F3> :Tabularize /\\$<CR>
vmap <F4> :Tabularize /=<CR>

let g:clang_complete_auto = 0
let g:clang_clang_hl_errors = 0
let g:clang_close_preview = 1
let g:clang_complete_macros = 1

if has('nvim')
	noremap <Leader>lf :Unite -smartcase -start-insert file_rec/neovim<CR>
	noremap <Leader>lr :UniteWithBufferDir -smartcase -start-insert file_rec/neovim<CR>
else
	noremap <Leader>lf :Unite -smartcase -start-insert file_rec/ascync<CR>
	noremap <Leader>lr :UniteWithBufferDir -smartcase -start-insert file_rec/async<CR>
end
noremap <Leader>lb :Unite -smartcase -start-insert buffer<CR>
noremap <Leader>ln :Unite file/new<CR>

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

let g:grepper = {'tools': ['git', 'grep'], 'open': 1, 'jump': 1}

let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaValidate = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
