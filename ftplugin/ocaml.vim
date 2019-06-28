setlocal et sw=2

function! OcamlFormat()
	if get(g:, 'OcamlFormat_autoformat', 1) != 0
		let view = winsaveview()
		execute "silent %!ocamlformat - --enable-outside-detected-project --name " . expand('%:t')
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "ocamlformat returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufEnter *.ml let g:LC_autoformat = 0
autocmd! BufWritePre *.ml call OcamlFormat()
