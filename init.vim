let $VIMHOME = expand('~/.config/nvim')
let $PATH .= ':'.$VIRTUALENVS.'/vim/bin'

let g:python3_host_prog = $VIRTUALENVS.'/vim/bin/python'
let g:python3_host_skip_check = 1

call plug#begin($VIMHOME.'/plugged')
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'fsouza/chapel.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'markcornick/vim-terraform'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'moll/vim-node'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'racer-rust/vim-racer'
Plug 'rhysd/vim-go-impl'
Plug 'Rip-Rip/clang_complete'
Plug 'rizzatti/dash.vim'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/unite.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tell-k/vim-autopep8'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-runtime'
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

let g:unite_source_rec_async_command = [
			\ 'pt', '-lfS', '--nocolor', '--hidden',
			\ '--ignore', '.git/*', '--ignore', '.hg/*',
			\ '']

let g:grepper = {'tools': ['git', 'grep'], 'open': 1, 'jump': 1}

let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaValidate = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

nmap <silent> <leader>D <Plug>DashSearch
