function s:lc_init()
	if get(g:, 'LC_enable_mappings', 1) != 0 && get(b:, 'LC_enable_mappings', 1) != 0
		inoremap <silent><expr> <c-x><c-o> coc#refresh()
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> <Leader>r :call CocAction('rename')<CR>
		nmap <silent> <Leader>i :call CocActionAsync('doHover')<CR>
		nmap <silent> <Leader>s :call CocActionAsync('highlight')<CR>
		nmap <silent> <Leader>T :<C-u>CocList symbols<CR>
		nmap <silent> <Leader>t :<C-u>CocList outline<CR>
		nmap <silent> <Leader>ld :<C-u>CocList diagnostics<CR>
		nmap <silent> <Leader>d :call CocActionAsync('diagnosticInfoFloat')<CR>
		nmap <silent> , :call CocActionAsync('diagnosticInfoFloat')<CR>
		nmap <silent> <Leader>q <Plug>(coc-references)
		nmap <silent> <Leader>lc :<C-u>CocRebuild<CR>
		nmap <silent> <Leader>ll <Plug>(coc-codelens-action)
		nmap <silent> <Leader>c <Plug>(coc-codeaction)
		vmap <silent> <Leader>c <Plug>(coc-codeaction-selected)
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
