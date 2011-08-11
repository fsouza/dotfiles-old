"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>

"Tabs navigation
nmap <C-Tab> gt
nmap <C-S-Tab> gT

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"Moving lines
noremap <C-j> :m+<CR>==
noremap <C-k> :m-2<CR>==
noremap <C-j> <Esc>:m+<CR>==gi
noremap <C-k> <Esc>:m-2<CR>==gi
noremap <C-j> :m'>+<CR>gv=gv
noremap <C-k> :m-2<CR>gv=gv

vnoremap <C-l> xp
vnoremap <C-h> xhP

"Split resizing
map <C-S-Left> <c-w><
map <C-S-Right> <c-w>>
map <C-S-Up> <c-w>-
map <C-S-Down> <c-w>+
