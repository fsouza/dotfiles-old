set term=builtin_ansi

"Setting VIMHOME
let $VIMHOME = $HOME."/.vim"

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$VIMHOME."/python"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

syntax on
filetype indent on
filetype plugin on

"Hidden mode
set hidden
set number

"Setting up tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabpagemax=20
set showtabline=4
set autoindent
set expandtab
set smartindent
set smarttab
set wildmenu
set wildmode=list:longest

"Colorscheme
colorscheme moria

"guifont
set guifont=Monaco:h12

"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

source $VIMHOME/modules/cucumber.vim
source $VIMHOME/modules/django.vim
source $VIMHOME/modules/make.vim
source $VIMHOME/modules/mapping.vim
source $VIMHOME/modules/markdown.vim
source $VIMHOME/modules/php.vim
source $VIMHOME/modules/python.vim
source $VIMHOME/modules/ruby.vim
source $VIMHOME/github.vim

if has("gui_running")
    set guioptions=egmt
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif
