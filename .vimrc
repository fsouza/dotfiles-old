set term=builtin_ansi

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

"Syntax
syntax on

"Hidden mode
set hidden

"Setting up tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabpagemax=20
set showtabline=4
set smarttab
set autoindent
set smartindent
set expandtab

"Set noexpandtab to Makefiles, to use <tab> char instead of spaces
autocmd FileType make setlocal noexpandtab

"Setting file type to PHP and HTML (snippets)
autocmd FileType php set ft=php.html

"Displaying line numbers
set number

"Colorscheme
colorscheme moria

"guifont
set guifont=Monaco:h12

"Indent on
filetype indent on
filetype plugin on

"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

"Markdown syntax
autocmd BufRead,BufNewFile *.mkd setfiletype markdown
autocmd BufRead,BufNewFile *.markdown setfiletype markdown
autocmd BufRead,BufNewFile *.md setfiletype markdown

"Cucumber syntax
autocmd BufRead,BufNewFile *.feature setfiletype cucumber
autocmd BufRead,BufNewFile *.feature setfiletype cucumber
