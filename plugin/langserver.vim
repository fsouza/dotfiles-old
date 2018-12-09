let g:LanguageClient_serverCommands = {
	\ 'c': ['clangd', '-index'],
	\ 'cpp': ['clangd'],
	\ 'dockerfile': ['docker-langserver', '--stdio'],
	\ 'fortran': ['fortls'],
	\ 'java': [$VIMHOME.'/bin/jdtls'],
	\ 'javascript': ['typescript-language-server', '--stdio'],
	\ 'ocaml': ['ocaml-language-server', '--stdio'],
	\ 'python': ['pyls'],
	\ 'reason': ['ocaml-language-server', '--stdio'],
	\ 'rust': ['rls'],
	\ 'typescript': ['typescript-language-server', '--stdio'],
	\ }

let g:LanguageClient_documentHighlightDisplay = {
	 \ 1: {
	 \	"name": "Text",
	 \	"texthl": "LangClientText",
	 \ },
	 \ 2: {
	 \	"name": "Read",
	 \	"texthl": "LangClientRead",
	 \ },
	 \ 3: {
	 \	"name": "Write",
	 \	"texthl": "LangClientWrite",
	 \ },
\ }

function LC_init()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>
		nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
		nnoremap <silent> <Leader>i :call LanguageClient#textDocument_hover()<CR>
		nnoremap <silent> <Leader>s :call LanguageClient#textDocument_documentHighlight()<CR>
		nnoremap <silent> <Leader>t :call LanguageClient#workspace_symbol()<CR>
	endif
endfunction

function LC_autoformat()
	if has_key(g:LanguageClient_serverCommands, &filetype) && get(g:, 'LC_autoformat', 1) != 0
		call LanguageClient_runSync('LanguageClient#textDocument_formatting', {'handle': v:true})
	endif
endfunction

autocmd FileType * call LC_init()
autocmd BufWritePre * call LC_autoformat()
