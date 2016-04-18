let g:go_fmt_autosave = 0
let g:go_fmt_options = '-s'

au FileType go nmap <Leader>gd <Plug>(go-def-tab)
