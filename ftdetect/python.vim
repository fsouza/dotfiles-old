"Set smartindent for Python files
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"Map to execute Python files
autocmd FileType python map <Leader>p :!python % <CR>

"Pylint
autocmd FileType python compiler pylint
"To disable calling Pylint every time a buffer is saved put into .vimrc file
let g:pylint_onwrite = 0
"Displaying code rate calculated by Pylint can be avoided by setting
"let g:pylint_show_rate = 0
"Openning of QuickFix window can be disabled with
"let g:pylint_cwindow = 0
"Of course, standard :make command can be used as in case

"Using Django and Python file type instead of just Python
autocmd FileType python set ft=python.django

"Rope stuffs
autocmd FileType python map <C-g> :RopeGotoDefinition<CR>
autocmd FileType python map <D-r> :RopeRename<CR>
autocmd FileType python vmap <D-Return> :RopeExtractMethod<CR>
