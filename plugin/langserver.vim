let g:LanguageClient_serverCommands = {
	\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ 'cpp': ['clangd'],
	\ }

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <Leader>i :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>s :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <Leader>t :call LanguageClient#workspace_symbol()<CR>
