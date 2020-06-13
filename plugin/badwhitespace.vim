if exists('g:fsouza#badwhitespace')
	finish
endif
let g:fsouza#badwhitespace = 1

autocmd BufEnter * highlight BadWhitespace ctermbg=160 guibg=#d70000
autocmd BufEnter * match BadWhitespace /\s\+$/
