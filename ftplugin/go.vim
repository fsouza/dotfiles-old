let g:LC_autoformat = 0

autocmd BufWritePre *.go call s:GoFormat()

function! s:GoFormat()
	let view = winsaveview()
	silent %!gofmt -s
	call winrestview(view)
endfunction
