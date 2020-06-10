function s:coc_enabled_for_current_ft()
	let services = CocAction('services')
	for svc in services
		for languageId in svc['languageIds']
			if languageId ==# &filetype
				return 1
			endif
		endfor
	endfor

	let extensions_stats = CocAction('extensionStats')
	for ext_stat in extensions_stats
		for activation_event in ext_stat['packageJSON']['activationEvents']
			if activation_event == 'onLanguage:' . &filetype
				return 1
			endif
		endfor
	endfor

	return 0
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
		call CocAction('format')
	endif
endfunction

function s:lc_init()
	if s:coc_enabled_for_current_ft() && get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nmap <silent> <buffer> <localleader>gd <Plug>(coc-definition)
		nmap <silent> <buffer> <localleader>gy <Plug>(coc-type-definition)
		nmap <silent> <buffer> <localleader>gi <Plug>(coc-implementation)
		nmap <silent> <buffer> <localleader>r :call CocAction('rename')<CR>
		nmap <silent> <buffer> <localleader>i :call CocActionAsync('doHover')<CR>
		nmap <silent> <buffer> <localleader>s :call CocActionAsync('highlight')<CR>
		nmap <silent> <buffer> <localleader>T :<C-u>CocList symbols<CR>
		nmap <silent> <buffer> <localleader>t :<C-u>CocList outline<CR>
		nmap <silent> <buffer> <localleader>cd :<C-u>CocList diagnostics<CR>
		nmap <silent> <buffer> <localleader>d :call CocActionAsync('diagnosticInfoFloat')<CR>
		nmap <silent> <buffer> <localleader>q <Plug>(coc-references)
		nmap <silent> <buffer> <localleader>cl <Plug>(coc-codelens-action)
		nmap <silent> <buffer> <localleader>cc <Plug>(coc-codeaction)
		vmap <silent> <buffer> <localleader>cc <Plug>(coc-codeaction-selected)
		nmap <silent> <buffer> <localleader>cf :CocFix<CR>
		xmap <silent> <buffer> <localleader>cf :CocFix<CR>

		autocmd BufWritePre <buffer> call s:lc_autoformat()
	endif
endfunction

autocmd User CocNvimInit call s:lc_init()

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
