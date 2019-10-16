function! Multiple_cursors_before()
	let g:LanguageClient_changeThrottle = 400
endfunction

function! Multiple_cursors_after()
	let g:LanguageClient_changeThrottle = v:null
endfunction
