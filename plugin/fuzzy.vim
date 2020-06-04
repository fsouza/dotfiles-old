function! s:fzf_grep()
	let what = input('rg\ ')
	execute 'FzfRg '.what
endfunction

let g:fzf_command_prefix = 'Fzf'
command! FzfGrep call s:fzf_grep()

nmap <silent> <leader>z :FzfFiles<CR>
nmap <silent> <leader>; :FzfCommands<CR>
nmap <silent> <leader>g :FzfGrep<CR>
nmap <silnet> <leader>m :FzfMarks<CR>

let g:LustyExplorerDefaultMappings = 0

nmap <silent> <Leader>lf :LustyFilesystemExplorer<CR>
nmap <silent> <Leader>lr :LustyFilesystemExplorerFromHere<CR>
nmap <silent> <Leader>lb :FzfBuffers<CR>
nmap <silent> <Leader>lg :FzfLines<CR>
