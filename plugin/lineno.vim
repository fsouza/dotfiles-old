function! s:toggle_lineno()
	setlocal relativenumber!
	setlocal number!
endfunction

command! ToggleLineno call s:toggle_lineno()

nmap <silent> <leader>n :ToggleLineno<CR>
