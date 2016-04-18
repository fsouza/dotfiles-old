let g:go_fmt_autosave = 0
let g:go_fmt_options = '-s'
let g:go_def_mapping_enabled = 0
let g:go_def_use_buffer = 1

au FileType go nmap gd <Plug>(go-def-tab)
