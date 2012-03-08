"Set smartindent for Python files
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"Using Django and Python file type instead of just Python
autocmd FileType python set ft=python.django

"Rope stuffs
autocmd FileType python map <C-g> :RopeGotoDefinition<CR>
autocmd FileType python map <F2> :RopeRename<CR>
