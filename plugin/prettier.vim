if exists('g:fsouza#prettier_loaded')
	finish
endif
let g:fsouza#prettier_loaded = 1

autocmd! BufEnter *.ts call fsouza#prettier#CheckTSPreferPrettier()

command! PreferPrettier call fsouza#prettier#OverrideLC(v:true)
