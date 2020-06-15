function! s:format_stdin(gate_var, format_cmd)
	if get(b:, a:gate_var, 1) != 0
		let view = winsaveview()
		execute 'silent %!' . a:format_cmd
		if v:shell_error
			% |
			undo
			echohl Error | echomsg 'failed to autoformat code with "' . format_cmd . '"' | echohl None
		endif
		call winrestview(view)
	endif
endfunction

function! fsouza#format#Dune()
	call s:format_stdin('dune_autoformat', 'dune format-dune-file')
endfunction

function! fsouza#format#Prettier()
	let l:fmt_cmd = 'npx prettier --stdin-filepath "' . expand('%:p') . '"'
	call s:format_stdin('Prettier_autoformat', l:fmt_cmd)
endfunction
