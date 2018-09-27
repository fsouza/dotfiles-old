let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_definitions_command = "gd"
let g:jedi#popup_on_dot = 0

let virtualenv = "vim"
if $VIRTUAL_ENV != ""
	let virtualenv = $VIRTUAL_ENV
endif

let g:black_virtualenv = $VIRTUALENVS.'/vim'
let g:pymode_python = 'python3'
let g:pymode_options = 0
let g:pymode_indent = 1
let g:pymode_breakpoint = 0
let g:pymode_options_max_line_length = 109
let g:pymode_virtualenv_path = $VIRTUALENVS.'/'.virtualenv

inoremap # X#
