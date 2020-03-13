function s:lc_init()
	if get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> <Leader>r <Plug>(coc-rename)
		nmap <silent> <Leader>i :call CocActionAsync('doHover')<CR>
		nmap <silent> <Leader>s :call CocActionAsync('highlight')<CR>
		nmap <silent> <Leader>t :<C-u>CocList -I symbols<CR>
		nmap <silent> <Leader>q <Plug>(coc-references)
		nmap <silent> <Leader>lc :<C-u>CocRebuild<CR>
		nmap <silent> <Leader>ll <Plug>(coc-codelens-action)
		nmap <silent> <Leader>c :CocAction<CR>
		xmap <silent> <Leader>c :CocAction<CR>
		nmap <silent> <Leader>f :CocFix<CR>
		xmap <silent> <Leader>f :CocFix<CR>
		nmap <silent> <Leader>ls <Plug>(coc-range-select)
		vmap <silent> <TAB> <Plug>(coc-range-select)
	endif
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
		call CocAction('format')
	endif
endfunction

autocmd FileType * call s:lc_init()
autocmd BufWritePre * call s:lc_autoformat()
