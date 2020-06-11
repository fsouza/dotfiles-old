let g:fzf_command_prefix = 'Fzf'

command! FzfGrep call fsouza#fuzzy#Rg()

nmap <silent> <leader>zz :FzfFiles<CR>
nmap <silent> <leader>zc :FzfCommands<CR>
nmap <silnet> <leader>zm :FzfMarks<CR>
nmap <silent> <Leader>zb :FzfBuffers<CR>
nmap <silent> <Leader>zg :FzfLines<CR>

nmap <silent> <leader>gg :FzfGrep<CR>
