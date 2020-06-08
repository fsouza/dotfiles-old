function s:coc_enabled_for_current_ft()
	if get(g:, 'did_coc_loaded', 0) != 1
		return 0
	endif

	let config = coc#util#get_config('languageserver')
	for svc in values(config)
		for ft in svc['filetypes']
			if ft ==? &filetype
				return 1
			endif
		endfor
	endfor

	" special case stuff that's enabled via coc extensions.
	if &filetype == 'json' || &filetype == 'typescript'
		return 1
	endif

	return 0
endfunction

" can we do this with an event from coc.nvim instead?
function s:lc_init()
	function s:lc_autoformat()
		if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
			call CocAction('format')
		endif
	endfunction

	if s:coc_enabled_for_current_ft() && get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nmap <silent> <localleader>gd <Plug>(coc-definition)
		nmap <silent> <localleader>gy <Plug>(coc-type-definition)
		nmap <silent> <localleader>gi <Plug>(coc-implementation)
		nmap <silent> <localleader>r :call CocAction('rename')<CR>
		nmap <silent> <localleader>i :call CocActionAsync('doHover')<CR>
		nmap <silent> <localleader>s :call CocActionAsync('highlight')<CR>
		nmap <silent> <localleader>T :<C-u>CocList symbols<CR>
		nmap <silent> <localleader>t :<C-u>CocList outline<CR>
		nmap <silent> <localleader>cd :<C-u>CocList diagnostics<CR>
		nmap <silent> <localleader>d :call CocActionAsync('diagnosticInfoFloat')<CR>
		nmap <silent> <localleader>q <Plug>(coc-references)
		nmap <silent> <localleader>cl <Plug>(coc-codelens-action)
		nmap <silent> <localleader>cc <Plug>(coc-codeaction)
		vmap <silent> <localleader>cc <Plug>(coc-codeaction-selected)
		nmap <silent> <localleader>cf :CocFix<CR>
		xmap <silent> <localleader>cf :CocFix<CR>
		nmap <silent> <localleader>cs <Plug>(coc-range-select)
		vmap <silent> <TAB> <Plug>(coc-range-select)

		autocmd BufWritePre <buffer> call s:lc_autoformat()
	endif
endfunction

autocmd FileType * call s:lc_init()

let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-snippets',
	\ 'coc-tsserver',
	\ 'coc-ultisnips'
	\ ]

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
