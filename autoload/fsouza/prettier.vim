function! fsouza#prettier#Enable_auto_format()
	let b:LC_autoformat = 0
	autocmd BufWritePre <buffer> call fsouza#format#Prettier()
endfunction
