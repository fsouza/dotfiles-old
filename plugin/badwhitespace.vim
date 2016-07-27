autocmd BufEnter * highlight BadWhitespace ctermbg=160 guibg=#d70000
autocmd BufEnter * match BadWhitespace /\s\+$/
