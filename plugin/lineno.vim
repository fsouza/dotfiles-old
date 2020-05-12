function! s:enable_rlu_on_write()
	if get(b:, 'no_relative_number', 0) != 1 && !&readonly
		setlocal relativenumber
	endif
endfunction

autocmd BufReadPost * call s:enable_rlu_on_write()
command! ToggleLineno setlocal relativenumber!

nmap <silent> ;; :ToggleLineno<CR>
