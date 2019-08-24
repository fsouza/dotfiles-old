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

map <silent> <leader>lz :FzfFiles<CR>
