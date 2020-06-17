let s:actions = {
			\ 'ctrl-t': 'tabedit',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit',
			\ }

function s:handle_lsp_line(lines)
	if len(a:lines) < 2
		return
	endif

	let match = matchlist(a:lines[1], '\v^([^:]+):(\d+):(\d+)')[1:3]
	if empty(match) || empty(match[0])
		return
	endif

	let filename = match[0]
	let lnum = match[1]
	let cnum = match[2]
	let action = get(s:actions, a:lines[0], 'edit')

	execute action filename
	call cursor(lnum, cnum)
	normal! zz
endfunction

function fsouza#lc#Fzf(items)
	call fzf#run(fzf#wrap(fzf#vim#with_preview({
				\ 'source': a:items,
				\ 'sink*': function('s:handle_lsp_line'),
				\ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
				\ })))
endfunction
