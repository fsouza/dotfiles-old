let g:go_fmt_options = '-s'
let g:go_fmt_experimental = 1
let g:go_def_mapping_enabled = 0
let g:go_metalinter_autosave = 1
let g:go_template_autocreate = 0
let g:go_snippet_case_type = 'camelcase'
let g:go_gocode_unimported_packages = 0
let g:go_info_mode = 'gocode'

let g:go_highlight_generate_tags = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 0
let g:go_highlight_build_constraints = 0

function! GoDef()
	let bin_path = go#path#CheckBinPath("guru")
	if empty(bin_path)
		return
	endif

	let old_gopath = $GOPATH
	let $GOPATH = go#path#Detect()

	let fname = fnamemodify(expand("%"), ':p:gs?\\?/?')
	let command = printf("%s definition %s:#%s", bin_path, shellescape(fname), go#util#OffsetCursor())

	let out = system(command)
	if !v:shell_error == 0
		call go#util#EchoError(out)
		return
	endif

	call s:doCustomJump(out)
	let $GOPATH = old_gopath
endfunction

function! s:doCustomJump(out)
	" strip line ending
	let out = split(a:out, go#util#LineEnding())[0]
	if go#util#IsWin()
		let parts = split(out, '\(^[a-zA-Z]\)\@<!:')
	else
		let parts = split(out, ':')
	endif

	let filename = parts[0]
	let line = parts[1]
	let col = parts[2]
	let ident = parts[3]

	" needed for restoring back user setting this is because there are two
	" modes of switchbuf which we need based on the split mode
	let old_switchbuf = &switchbuf

	let &switchbuf = "usetab"
	if filename !~ "^".expand("%:p")
		tab split
	endif

	" open the file and jump to line and column
	exec 'edit '.filename
	call cursor(line, col)

	" also align the line to middle of the view
	normal! zz

	let &switchbuf = old_switchbuf
endfunction

autocmd FileType go nmap gd :call GoDef()<CR>
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>e <Plug>(go-rename)
autocmd FileType go nmap <Leader>b <Plug>(go-build)
autocmd FileType go nmap <Leader>d <Plug>(go-describe)

autocmd FileType go nmap <C-s> :GoSameIds<CR>
