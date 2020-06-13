let g:fzf_command_prefix = 'Fzf'

command! FzfGrep call fsouza#fuzzy#Rg()

nmap <silent> <leader>zz <cmd>FzfFiles<CR>
nmap <silent> <leader>; <cmd>FzfCommands<CR>
nmap <silnet> <leader>zm <cmd>FzfMarks<CR>
nmap <silent> <leader>zb <cmd>FzfBuffers<CR>
nmap <silent> <leader>zl <cmd>FzfLines<CR>
nmap <silent> <leader>gg <cmd>FzfGrep<CR>
nmap <silent> <leader>gq <cmd>FzfQuickfix<CR>
