function! TerraformFmt()
	if get(b:, 'TerraformFmt_autoformat', 1) != 0 && executable("terraform")
		let view = winsaveview()
		execute "silent %!terraform fmt -"
		if v:shell_error
			% |
			undo
			echohl Error | echomsg "terraform fmt returned an error" | echohl None
		endif
		call winrestview(view)
	endif
endfunction

autocmd! BufWritePre *.tf call TerraformFmt()
