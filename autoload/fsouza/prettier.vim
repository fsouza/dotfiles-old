function! fsouza#prettier#Enable_auto_format()
	autocmd BufWritePre <buffer> call fsouza#format#Prettier()
endfunction
