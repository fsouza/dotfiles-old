function local#Lsp_fzf(items, prompt)
	let preview = stdpath('config') . '/scripts/fzf-preview-col.lua {}'

	call fzf_preview#runner#fzf_run({
				\ 'source': a:items,
				\ 'prompt': a:prompt,
				\ 'sink': {lines -> v:lua.f.fzf.handle_lsp_line(lines)},
				\ 'options': fzf_preview#command#get_command_options(a:prompt, preview),
				\ })
endfunction
