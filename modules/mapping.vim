"NERDTree
nmap <silent> <c-p> :NERDTreeToggle<CR>
nmap <silent> <c-a> :NERDTree<CR>

"Tabs navigation
nmap <C-Tab> gt
nmap <C-S-Tab> gT

"Command-T
nmap <C-t> :CommandT<CR>

"Lusty
nmap <C-x> :LustyFilesystemExplorer<CR>
nmap <C-c> :LustyFilesystemExplorerFromHere<CR>

" Removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
:endfunction

map <Leader>o :call TrimWhiteSpace()<CR>

"Moving lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
