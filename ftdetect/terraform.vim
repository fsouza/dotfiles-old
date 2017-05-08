autocmd FileType terraform setlocal softtabstop=2 expandtab
autocmd FileType terraform nmap <Leader>f :TerraformFmt<CR>
autocmd BufRead,BufNewFile *.tfstate setlocal softtabstop=2 expandtab
autocmd BufWritePre *.tf TerraformFmt
