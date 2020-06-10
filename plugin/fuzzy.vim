let g:fzf_command_prefix = 'Fzf'

command! FzfGrep call fsouza#fuzzy#Rg()

nmap <silent> <leader>ff :FzfFiles<CR>
nmap <silent> <leader>fc :FzfCommands<CR>
nmap <silnet> <leader>fm :FzfMarks<CR>
nmap <silent> <Leader>fb :FzfBuffers<CR>
nmap <silent> <Leader>fg :FzfLines<CR>

nmap <silent> <leader>gg :FzfGrep<CR>
