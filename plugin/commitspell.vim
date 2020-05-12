function! s:commitspell()
	let b:no_auto_relative_number = 1
	setlocal spell
endfunction

autocmd FileType gitcommit call s:commitspell()
autocmd BufEnter TAG_EDITMSG call s:commitspell()
autocmd FileType hgcommit call s:commitspell()
