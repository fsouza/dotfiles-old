if exists('g:fsouza#lc_loaded')
	finish
endif
let g:fsouza#lc_loaded = 1

lua require('lc').setup()
