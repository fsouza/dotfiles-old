function VCSTags(vcs)
	if filereadable('.'.a:vcs.'/tags')
		set tags=.hg/tags
	endif
endfunction

autocmd VimEnter * call VCSTags('hg')
autocmd VimEnter * call VCSTags('git')
