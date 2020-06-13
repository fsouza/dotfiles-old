if exists('g:fsouza#hlyank_loaded')
	finish
endif
let g:fsouza#hlyank_loaded = 1

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank('HlYank', 300)
