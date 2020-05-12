function! s:enable_rlu_on_writable_buffers()
	if get(b:, 'no_auto_relative_number', 0) != 1 && !&readonly
		setlocal relativenumber
	endif
endfunction

autocmd BufEnter * call s:enable_rlu_on_writable_buffers()
command! ToggleLineno setlocal relativenumber!

nmap <silent> ;; :ToggleLineno<CR>
