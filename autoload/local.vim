function local#Lsp_fzf(items)
	call fzf_preview#runner#fzf_run({
				\ 'source': a:items,
				\ 'sink': {lines -> v:lua.f.fzf.handle_lsp_line(lines)}
				\ })
endfunction
