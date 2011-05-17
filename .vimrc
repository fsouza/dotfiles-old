set term=builtin_ansi

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$HOME."/.vim/python"

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

nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <C-t> :CommandT<CR>

nmap <C-x> :LustyFilesystemExplorer<CR>
nmap <C-c> :LustyFilesystemExplorerFromHere<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

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

"Moving lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
