function! s:prefer_prettier()
	if get(b:, 'TSPreferPrettier', 0) == 1
		let b:LC_autoformat = 0
		let b:Prettier_autoformat = 1
	endif
endfunction

function! s:prettier_fmt()
	if get(b:, 'Prettier_autoformat', 0) == 1
		let view = winsaveview()
		execute "silent %!npx prettier --stdin-filepath " . expand('%:p')
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "ocamlformat returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufEnter *.ts call s:prefer_prettier()
autocmd! BufWritePre *.ts call s:prettier_fmt()
