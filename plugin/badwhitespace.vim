autocmd BufEnter * highlight BadWhitespace ctermbg=196 guibg=#990000
autocmd BufEnter * match BadWhitespace /\s\+$/
