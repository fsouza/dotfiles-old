autocmd FileType terraform setlocal shiftwidth=2 expandtab
autocmd FileType terraform nmap <Leader>f :TerraformFmt<CR>
autocmd BufRead,BufNewFile *.tfstate setlocal shiftwidth=2 expandtab
autocmd BufWritePre *.tf TerraformFmt
