setlocal et sw=2
let no_ocaml_maps = 1

function! s:ocaml_enter()
	if exists('g:LC_autoformat')
		let b:ocamlformat_autoformat = 0
	else
		let b:LC_autoformat = 0
	endif
endfunction

function! s:ocamlformat()
	if get(b:, 'ocamlformat_autoformat', 1) != 0
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

autocmd! BufEnter *.ml call s:ocaml_enter()
autocmd! BufWritePre *.ml call s:ocamlformat()
