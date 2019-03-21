nnoremap <silent> gd :EnDeclaration<CR>
nnoremap <silent> <Leader>i :EnType<CR>
nnoremap <silent> <Leader>r :EnRename<CR>
nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <Leader>s :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <Leader>t :call LanguageClient#workspace_symbol()<CR>
nnoremap <silent> <Leader>q :call LanguageClient#textDocument_references()<CR>

set omnifunc=EnCompleteFunc
