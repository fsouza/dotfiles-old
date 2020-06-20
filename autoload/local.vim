function local#Lsp_fzf(items)
	call fzf#run(fzf#wrap(fzf#vim#with_preview({
				\ 'source': a:items,
				\ 'sink*': {lines -> v:lua.f.fzf.handle_lsp_line(lines)},
				\ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --bind ctrl-q:select-all',
				\ })))
endfunction
