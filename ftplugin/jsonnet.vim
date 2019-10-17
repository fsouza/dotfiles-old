function! JsonnetFormat()
	if get(b:, 'jsonnetfmt_autoformat', 1) != 0
		let view = winsaveview()
		execute "silent %!jsonnetfmt -"
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "jsonnetfmt returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufWritePre *.jsonnet call JsonnetFormat()
