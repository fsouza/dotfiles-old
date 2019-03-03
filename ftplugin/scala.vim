nnoremap <localleader>i :EnType<CR>
nnoremap gd :EnDeclaration<CR>
nnoremap <localleader>r :EnRename<CR>

function! ScalaFmt()
	if get(g:, 'ScalaFmt_autoformat', 1) != 0
		try | silent undojoin | catch | endtry
		let view = winsaveview()
		setlocal shellredir=>
		silent %!scalafmt --stdin --stdout
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "scalafmt returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufWritePre *.scala call ScalaFmt()
