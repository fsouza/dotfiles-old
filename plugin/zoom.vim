if exists('g:fsouza#zoom_loaded')
	finish
endif
let g:fsouza#zoom_loaded = 1

command! ZoomIn call fsouza#zoom#In()
command! ZoomOut call fsouza#zoom#Out()
