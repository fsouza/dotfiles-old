if exists('g:fsouza#lc_loaded')
	finish
endif
let g:fsouza#lc_loaded = 1

if has('nvim')
	lua require('lc').setup()
end
