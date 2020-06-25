function local#Lsp_fzf(items, prompt)
	call fzf_preview#runner#fzf_run({
				\ 'source': a:items,
				\ 'prompt': a:prompt,
				\ 'sink': {lines -> v:lua.f.fzf.handle_lsp_line(lines)}
				\ })
endfunction
