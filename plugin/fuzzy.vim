let g:fzf_command_prefix = 'Fzf'

command! FzfGrep call fsouza#fuzzy#Rg()

nmap <silent> <leader>zz <cmd>FzfFiles<CR>
nmap <silent> <leader>zc <cmd>FzfCommands<CR>
nmap <silnet> <leader>zm <cmd>FzfMarks<CR>
nmap <silent> <Leader>zb <cmd>FzfBuffers<CR>
nmap <silent> <Leader>zg <cmd>FzfLines<CR>

nmap <silent> <leader>gg <cmd>FzfGrep<CR>
