function! s:fzf_grep()
	let what = input('rg\ ')
	execute 'FzfRg '.what
endfunction

let g:fzf_command_prefix = 'Fzf'
command! FzfGrep call s:fzf_grep()

nmap <silent> <leader>ff :FzfFiles<CR>
nmap <silent> <leader>fc :FzfCommands<CR>
nmap <silnet> <leader>fm :FzfMarks<CR>
nmap <silent> <Leader>fb :FzfBuffers<CR>
nmap <silent> <Leader>fg :FzfLines<CR>

nmap <silent> <leader>gg :FzfGrep<CR>
