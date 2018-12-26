let g:LanguageClient_serverCommands = {
	\ 'c': ['clangd', '-index', '-pch-storage=memory'],
	\ 'cpp': ['clangd', '-index', '-pch-storage=memory'],
	\ 'css': ['css-languageserver', '--stdio'],
	\ 'dockerfile': ['docker-langserver', '--stdio'],
	\ 'fortran': ['fortls'],
	\ 'html': ['html-languageserver', '--stdio'],
	\ 'java': [$VIMHOME.'/bin/jdtls'],
	\ 'javascript': ['typescript-language-server', '--stdio'],
	\ 'less': ['css-languageserver', '--stdio'],
	\ 'ocaml': ['ocaml-language-server', '--stdio'],
	\ 'python': ['pyls'],
	\ 'reason': ['ocaml-language-server', '--stdio'],
	\ 'rust': ['rls'],
	\ 'scss': ['css-languageserver', '--stdio'],
	\ 'sh': ['bash-language-server', 'start'],
	\ 'typescript': ['typescript-language-server', '--stdio'],
	\ 'yaml': [$VIMHOME.'/bin/yls'],
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

let g:LanguageClient_hasSnippetSupport = 0

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
