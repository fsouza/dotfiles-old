function! s:fzf_grep()
	let what = input('what? ')
	execute 'FzfRg '.what
endfunction

let g:fzf_command_prefix = 'Fzf'
let g:fzf_colors = {
	\ 'fg': ['fg', 'Normal'],
	\ 'bg': ['bg', 'Normal'],
	\ 'hl': ['fg', 'Normal'],
	\ 'fg+': ['fg', 'Normal'],
	\ 'bg+': ['bg', 'Normal'],
	\ 'hl+': ['fg', 'Normal'],
	\ 'info': ['fg', 'Normal'],
	\ 'prompt': ['fg', 'Normal'],
	\ 'pointer': ['fg', 'Normal'],
	\ 'marker': ['fg', 'Normal'],
	\ 'spinner': ['fg', 'Normal'],
	\ 'header': ['fg', 'Normal'] }

command! FzfGrep call s:fzf_grep()

nmap <silent> <leader>lf :FzfFiles<CR>
nmap <silent> <leader>lz :FzfFiles<CR>
nmap <silent> <leader>lr :call fzf#vim#files(expand('%:p:h'))<CR>
nmap <silent> <leader>lb :FzfBuffers<CR>
nmap <silent> <leader>lh :FzfHistory<CR>
nmap <silent> <leader>lg :FzfLines<CR>
nmap <silent> <leader>; :FzfCommands<CR>
nmap <silent> <leader>g :FzfGrep<CR>
