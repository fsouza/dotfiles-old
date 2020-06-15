function fsouza#lc#LC_attached(enable_autoformat)
	if get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		nnoremap <silent> <buffer> <localleader>gd <cmd>lua vim.lsp.buf.definition()<CR>
		nnoremap <silent> <buffer> <localleader>gy <cmd>lua vim.lsp.buf.declaration()<CR>
		nnoremap <silent> <buffer> <localleader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
		nnoremap <silent> <buffer> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
		nnoremap <silent> <buffer> <localleader>i <cmd>lua vim.lsp.buf.hover()<CR>
		nnoremap <silent> <buffer> <localleader>s <cmd>lua vim.lsp.buf.document_highlight()<CR>
		nnoremap <silent> <buffer> <localleader>T <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
		nnoremap <silent> <buffer> <localleader>t <cmd>lua vim.lsp.buf.document_symbol()<CR>
		nnoremap <silent> <buffer> <localleader>q <cmd>lua vim.lsp.buf.references()<CR>
		nnoremap <silent> <buffer> <localleader>cc <cmd>lua vim.lsp.buf.code_action()<CR>
		nnoremap <silent> <buffer> <localleader>d <cmd>lua require('lc').show_line_diagnostics()<CR>
		nnoremap <silent> <buffer> <localleader>f <cmd>lua vim.lsp.buf.formatting()<CR>
		nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
		inoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

		if a:enable_autoformat
			autocmd BufWritePre <buffer> call s:lc_autoformat()
		end
	endif
endfunction

function s:handle_lsp_line(line)
	let match = matchlist(a:line, '\v^([^:]+):(\d+):(\d+)')[1:3]
	if empty(match) || empty(match[0])
		return
	endif

	let filename = match[0]
	let lnum = match[1]
	let cnum = match[2]

	execute 'edit' filename
	call cursor(lnum, cnum)
	normal! zz
endfunction

function fsouza#lc#Fzf(items)
	call fzf#run(fzf#wrap(fzf#vim#with_preview({
				\ 'source': a:items,
				\ 'sink': function('s:handle_lsp_line'),
				\ })))
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
		lua require('lc').formatting_sync({timeout_ms=500})
	endif
endfunction
