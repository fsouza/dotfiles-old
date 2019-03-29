function! PyIsort()
	if get(g:, 'Py_auto_isort', 1) != 0
		let view = winsaveview()
		execute "silent %!isort -"
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "scalafmt returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufWritePre *.py call PyIsort()
