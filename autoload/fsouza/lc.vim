function fsouza#lc#LC_attached(enable_autoformat)
	if get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		nmap <silent> <buffer> <localleader>gd <cmd>lua vim.lsp.buf.definition()<CR>
		nmap <silent> <buffer> <localleader>gy <cmd>lua vim.lsp.buf.declaration()<CR>
		nmap <silent> <buffer> <localleader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
		nmap <silent> <buffer> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
		nmap <silent> <buffer> <localleader>i <cmd>lua vim.lsp.buf.hover()<CR>
		nmap <silent> <buffer> <localleader>s <cmd>lua vim.lsp.buf.document_highlight()<CR>
		nmap <silent> <buffer> <localleader>T <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
		nmap <silent> <buffer> <localleader>t <cmd>lua vim.lsp.buf.document_symbol()<CR>
		nmap <silent> <buffer> <localleader>q <cmd>lua vim.lsp.buf.references()<CR>
		nmap <silent> <buffer> <localleader>cc <cmd>lua vim.lsp.buf.code_action()<CR>
		nmap <silent> <buffer> <localleader>d <cmd>lua require('lc').show_line_diagnostics()<CR>
		nmap <silent> <buffer> <localleader>f <cmd>lua vim.lsp.buf.formatting()<CR>
		nmap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
		imap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

		if a:enable_autoformat
			autocmd BufWritePre <buffer> call s:lc_autoformat()
		end
	endif
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
		lua require('lc').formatting_sync({timeout_ms=500})
	endif
endfunction
