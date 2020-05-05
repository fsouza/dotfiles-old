function! s:toggle_lineno()
	setlocal relativenumber!
endfunction

command! ToggleLineno call s:toggle_lineno()

nmap <silent> ;; :ToggleLineno<CR>
