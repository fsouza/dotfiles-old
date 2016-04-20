let g:go_fmt_autosave = 1
let g:go_fmt_options = '-s'
let g:go_def_mapping_enabled = 0
let g:go_def_use_buffer = 1

let g:godef_split = 2
let g:godef_same_file_in_same_window = 1

autocmd FileType go nmap <Leader>l :GoLint<CR>
autocmd FileType go nmap <Leader>v :GoVet<CR>
autocmd FileType go nmap <Leader>i :GoImport 
autocmd FileType go nmap <Leader>d :GoDrop 
