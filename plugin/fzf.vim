function! s:fzf_grep()
	let what = input('what? ')
	execute 'FzfRg '.what
endfunction

let g:fzf_command_prefix = 'Fzf'
command! FzfGrep call s:fzf_grep()

nmap <silent> <leader>lz :FzfFiles<CR>
nmap <silent> <leader>lh :FzfHistory<CR>
nmap <silent> <leader>; :FzfCommands<CR>
nmap <silent> <leader>g :FzfGrep<CR>
