"Setting VIMHOME
let $VIMHOME = $HOME."/.vim"

"Setting PYTHONPATH
let $PYTHONPATH .= ":".$VIMHOME."/python"

"Setting PATH
let $PATH .= ":".$VIMHOME."/python:".$VIMHOME."/bundle/c.vim/bin"

"Loading bundle plugins
call pathogen#runtime_append_all_bundles()

syntax off
filetype plugin on
filetype indent on

"Hidden mode
set hidden
set number

"Backspace
set backspace=2

"Bad whitespaces
autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /^\t\+/
autocmd BufEnter * match BadWhitespace /\s\+$/

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

"Start mappings
"==============
"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <S-f> :NERDTreeFind<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
    ''
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"============
"End mappings
