function fsouza#complete#Complete()
	call deoplete#custom#option('auto_complete', v:true)
	autocmd InsertLeave <buffer> call deoplete#custom#option('auto_complete', v:false)
	return deoplete#manual_complete()
endfunction
