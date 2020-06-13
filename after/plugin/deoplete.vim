call deoplete#custom#option({
			\ 'auto_refresh_delay': 0,
			\ })

call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
