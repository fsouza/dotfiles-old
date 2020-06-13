function! fsouza#zoom#In()
	call nvim_feedkeys(nvim_replace_termcodes("<C-w>_", v:true, v:false, v:true), "n", v:false)
	call nvim_feedkeys(nvim_replace_termcodes("<C-w>|", v:true, v:false, v:true), "n", v:false)
endfunction

function! fsouza#zoom#Out()
	call nvim_feedkeys(nvim_replace_termcodes("<C-w>=", v:true, v:false, v:true), "n", v:false)
endfunction
