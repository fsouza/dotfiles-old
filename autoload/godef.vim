if exists('g:loaded_godef')
  finish
endif
let g:loaded_godef = 1

function! godef#Def()
	let bin_path = go#path#CheckBinPath("guru")
	if empty(bin_path)
		return
	endif

	let fname = fnamemodify(expand("%"), ':p:gs?\\?/?')
	let command = printf("%s definition %s:#%s", bin_path, shellescape(fname), go#util#OffsetCursor())

	let out = system(command)
	if !v:shell_error == 0
		call go#util#EchoError(out)
		return
	endif

	call s:doCustomJump(out)
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
