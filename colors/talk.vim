" Vim color file
" Maintainer:	Francisco Souza <f@souza.cc>
" Last Change:	2017 Jan 11

set background=light
highlight clear
if exists('syntax_on')
	syntax reset
endif

runtime colors/boring.vim

let g:colors_name = 'talk'

highlight Boolean ctermfg=200 guifg=#ff00d7
highlight Character ctermfg=200 guifg=#ff00d7
highlight Comment ctermfg=27 guifg=#005fff
highlight Conditional ctermfg=56 guifg=#5f00ff
highlight Float ctermfg=200 guifg=#ff00d7
highlight Include ctermfg=56 guifg=#5f00ff
highlight Keyword ctermfg=56 guifg=#5f00ff
highlight Number ctermfg=200 guifg=#ff00d7
highlight PreCondit ctermfg=56 guifg=#5f00ff
highlight Repeat ctermfg=56 guifg=#5f00ff
highlight SpecialComment ctermfg=27 guifg=#005fff
highlight Statement ctermfg=56 guifg=#5f00ff
highlight StorageClass ctermfg=56 guifg=#5f00ff
highlight String ctermfg=200 guifg=#ff00d7
highlight Structure ctermfg=56 guifg=#5f00ff
highlight Todo ctermfg=27 gui=bold guifg=#005fff
highlight Type ctermfg=56 guifg=#5f00ff
highlight Typedef ctermfg=56 guifg=#5f00ff
