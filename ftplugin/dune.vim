function! s:duneformat()
	if get(b:, 'dune_autoformat', 1) != 0
		let view = winsaveview()
		execute "silent %!dune format-dune-file"
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "dune returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufWritePre dune call s:duneformat()
