function! fsouza#fuzzy#Rg()
	let what = input('rg\ ')
	execute 'FzfRg '.what
endfunction
