if exists('g:fsouza#badwhitespace')
	finish
endif
let g:fsouza#badwhitespace = 1

autocmd BufEnter * match BadWhitespace /\s\+$/
