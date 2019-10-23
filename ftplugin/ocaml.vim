setlocal et sw=2
let no_ocaml_maps = 1

function! OcamlFormat()
	if get(b:, 'OcamlFormat_autoformat', 1) != 0
		let view = winsaveview()
		execute "silent %!ocamlformat - --enable-outside-detected-project --name " . expand('%:p')
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
