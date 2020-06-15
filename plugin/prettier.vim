if exists('g:fsouza#prettier_loaded')
	finish
endif
let g:fsouza#prettier_loaded = 1

command! PrettierFormat call fsouza#format#Prettier()
