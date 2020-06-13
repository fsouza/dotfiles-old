if exists('g:fsouza#lineno_loaded')
	finish
endif
let g:fsouza#lineno_loaded = 1

function! s:enable_rlu_on_writable_buffers()
	if get(b:, 'no_auto_relative_number', 0) != 1 && !&readonly
		setlocal relativenumber
	endif
endfunction

autocmd BufEnter * call s:enable_rlu_on_writable_buffers()
