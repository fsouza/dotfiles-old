function s:lc_init()
	if get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> <Leader>r <Plug>(coc-rename)
		nmap <silent> <Leader>f :call CocAction('format')<CR>
		nmap <silent> <Leader>i :call CocActionAsync('doHover')<CR>
		nmap <silent> <Leader>s :call CocActionAsync('highlight')<CR>
		nmap <silent> <Leader>t :<C-u>CocList -I symbols<CR>
		nmap <silent> <Leader>q <Plug>(coc-references)
		nmap <silent> <Leader>c <Plug>(coc-codeaction)
		nmap <silent> <Leader>lc :<C-u>CocRestart<CR>
	endif
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0 && get(b:, 'LC_autoformat', 1) != 0
		call CocAction('format')
	endif
endfunction

autocmd FileType * call s:lc_init()
autocmd BufWritePre * call s:lc_autoformat()
