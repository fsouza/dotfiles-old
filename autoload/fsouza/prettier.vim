function! fsouza#prettier#OverrideLC(global)
	if a:global
		let g:LC_autoformat = 0
		let g:Prettier_autoformat = 1
	else
		let b:LC_autoformat = 0
		let b:Prettier_autoformat = 1
	endif
endfunction

function! fsouza#prettier#CheckTSPreferPrettier()
	if get(b:, 'TSPreferPrettier', 0) == 1
		call s:prefer_prettier(v:false)

		autocmd BufWritePre <buffer> call fsouza#prettier#Format()
	endif
endfunction

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


