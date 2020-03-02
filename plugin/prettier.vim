function! s:prefer_prettier(global)
	if a:global
		let g:LC_autoformat = 0
		let g:Prettier_autoformat = 1
	else
		let b:LC_autoformat = 0
		let b:Prettier_autoformat = 1
	endif
endfunction

function! s:flip_prettier_if_needed()
	if get(b:, 'TSPreferPrettier', 0) == 1
		call s:prefer_prettier(v:false)
	endif
endfunction

function! s:prettier_fmt()
	if get(b:, 'Prettier_autoformat', 0) == 1 || get(g:, 'Prettier_autoformat', 0) == 1
		let view = winsaveview()
		execute "silent %!npx prettier --stdin-filepath " . expand('%:p')
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "prettier returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufEnter *.ts call s:flip_prettier_if_needed()
autocmd! BufWritePre *.ts call s:prettier_fmt()

command PreferPrettier call s:prefer_prettier(v:true)
