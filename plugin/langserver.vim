function s:lc_init()
	if get(g:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nnoremap <silent> gd <Plug>(coc-definition)
		nnoremap <silent> <Leader>r <Plug>(coc-rename)
		nnoremap <silent> <Leader>f :call CocAction('format')<CR>
		nnoremap <silent> <Leader>i :call CocActionAsync('doHover')<CR>
		nnoremap <silent> <Leader>s :call CocActionAsync('highlight')<CR>
		nnoremap <silent> <Leader>t :<C-u>CocList -I symbols<CR>
		nnoremap <silent> <Leader>q <Plug>(coc-references>
		nnoremap <silent> <Leader>c <Plug>(coc-codeaction>
		nnoremap <silent> <Leader>lc :<C-u>CocRestart<CR>
	endif
endfunction

function s:lc_autoformat()
	if get(g:, 'LC_autoformat', 1) != 0
		call CocAction('format')
	endif
endfunction

autocmd FileType * call s:lc_init()
autocmd BufWritePre * call s:lc_autoformat()
