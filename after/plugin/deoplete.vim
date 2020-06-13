call deoplete#custom#option({
			\ 'auto_complete': v:false,
			\ 'auto_refresh_delay': 0,
			\ })

call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

inoremap <expr> <silent> <c-x><c-o> fsouza#complete#Complete()
