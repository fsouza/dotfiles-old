let g:LanguageClient_serverCommands = {
	\ 'c': ['clangd', '-index', '-pch-storage=memory'],
	\ 'cpp': ['clangd', '-index', '-pch-storage=memory'],
	\ 'css': ['css-languageserver', '--stdio'],
	\ 'dockerfile': ['docker-langserver', '--stdio'],
	\ 'fortran': ['fortls', '--lowercase_intrinsics'],
	\ 'go': ['gopls'],
	\ 'html': ['html-languageserver', '--stdio'],
	\ 'java': [$VIMHOME.'/bin/jdtls'],
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'json': ['json-languageserver', '--stdio'],
	\ 'ocaml': ['ocaml-language-server', '--stdio'],
	\ 'python': ['pyls'],
	\ 'reason': ['ocaml-language-server', '--stdio'],
	\ 'rust': ['rls'],
	\ 'scala': ['metals-vim'],
	\ 'typescript': ['javascript-typescript-stdio'],
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
let g:LanguageClient_useVirtualText = 0

let g:lc_complete_skip = []

function LC_init()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		if get(g:, 'LC_enable_mappings', 1) != 0
			nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
			nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>
			nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
			nnoremap <silent> <Leader>i :call LanguageClient#textDocument_hover()<CR>
			nnoremap <silent> <Leader>s :call LanguageClient#textDocument_documentHighlight()<CR>
			nnoremap <silent> <Leader>t :call LanguageClient#workspace_symbol()<CR>
			nnoremap <silent> <Leader>q :call LanguageClient#textDocument_references()<CR>
		endif

		if index(g:lc_complete_skip, &filetype) < 0
			setlocal omnifunc=LanguageClient#complete
		endif
	endif
endfunction

function LC_autoformat()
	if has_key(g:LanguageClient_serverCommands, &filetype) && get(g:, 'LC_autoformat', 1) != 0
		call LanguageClient#textDocument_formatting_sync()
	endif
endfunction

autocmd FileType * call LC_init()
autocmd BufWritePre * call LC_autoformat()
