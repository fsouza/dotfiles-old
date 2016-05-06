autocmd FileType terraform setlocal shiftwidth=2 showtabline=2 expandtab
autocmd FileType terraform nmap <Leader>f :TerraformFmt<CR>
autocmd BufRead,BufNewFile *.tfstate setlocal shiftwidth=2 showtabline=2 expandtab
