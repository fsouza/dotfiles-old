function! fsouza#prettier#Format()
	if get(g:, 'Prettier_autoformat', get(b:, 'Prettier_autoformat', 0)) == 1
		let view = winsaveview()
		execute "silent %!npx prettier --stdin-filepath '" . expand('%:p') . "'"
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "prettier returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

function! fsouza#prettier#Enable_auto_format()
	autocmd BufWritePre <buffer> call fsouza#prettier#Format()
endfunction
