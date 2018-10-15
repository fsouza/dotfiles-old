let g:LanguageClient_serverCommands = {
	\ 'c': ['clangd'],
	\ 'cpp': ['clangd'],
	\ 'dockerfile': ['docker-langserver', '--stdio'],
	\ 'fortran': ['fortls'],
	\ 'java': [$VIMHOME.'/bin/jdtls'],
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ 'ocaml': ['ocaml-language-server', '--stdio'],
	\ 'reason': ['ocaml-language-server', '--stdio'],
	\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ 'typescript': ['javascript-typescript-stdio'],
	\ }

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <Leader>i :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>s :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <Leader>t :call LanguageClient#workspace_symbol()<CR>
