function TrimWhiteSpace()
	let v = winsaveview()
	silent %s/\s\+$//e
	call winrestview(v)
endfunction

map <Leader>o :call TrimWhiteSpace()<CR>
