function local#Complete()
	call deoplete#custom#option('auto_complete', v:true)
	autocmd InsertLeave <buffer> call deoplete#custom#option('auto_complete', v:false)
	return deoplete#manual_complete()
endfunction

function local#Lsp_fzf(items)
	call fzf#run(fzf#wrap(fzf#vim#with_preview({
				\ 'source': a:items,
				\ 'sink*': {lines -> v:lua.lc_helpers.handle_lsp_line(lines)},
				\ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
				\ })))
endfunction
