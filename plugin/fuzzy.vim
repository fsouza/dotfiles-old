if exists('g:fsouza#fuzzy_loaded')
	finish
endif
let g:fsouza#fuzzy_loaded = 1

let g:fzf_command_prefix = 'Fzf'

command! FzfGrep call fsouza#fuzzy#Rg()

nnoremap <silent> <leader>zz <cmd>FzfFiles<CR>
nnoremap <silent> <leader>; <cmd>FzfCommands<CR>
nnoremap <silent> <leader>zb <cmd>FzfBuffers<CR>
nnoremap <silent> <leader>zl <cmd>FzfLines<CR>
nnoremap <silent> <leader>gg <cmd>FzfGrep<CR>
nnoremap <silent> <leader>gq <cmd>FzfQuickfix<CR>
