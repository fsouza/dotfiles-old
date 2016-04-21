let $VIMHOME = expand("~/.config/nvim")
let $PATH .= ":".$VIMHOME."/plugged/c-cpp-java-format.vim/bin"

let g:python3_host_prog = $VIRTUALENVS."/vim/bin/python"
let g:python3_host_skip_check = 1

call plug#begin($VIMHOME.'/plugged')
Plug 'tpope/vim-surround'
Plug 'fsouza/c-cpp-java-format.vim'
Plug 'Rip-Rip/clang_complete'
Plug 'nvie/vim-flake8'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tpope/vim-dispatch'
Plug 'tell-k/vim-autopep8'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'phildawes/racer'
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
Plug 'garyburd/go-explorer'
Plug 'Shougo/unite.vim'
Plug 'dgryski/vim-godef'
Plug 'rhysd/vim-go-impl'
Plug 'mhinz/vim-grepper'
call plug#end()

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
let s:osvimrc = $VIMHOME."/etc/".s:uname.".vim"
if filereadable(s:osvimrc)
	execute "source ".s:osvimrc
endif

if has("nvim")
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

colorscheme boring

let g:grepper = {'tools': ['git', 'grep'], 'open': 1, 'jump': 1}
