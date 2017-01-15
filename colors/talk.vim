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
highlight Comment ctermfg=69 guifg=#5f87ff
highlight Conditional ctermfg=124 guifg=#af0000
highlight Float ctermfg=200 guifg=#ff00d7
highlight Include ctermfg=124 guifg=#af0000
highlight Keyword ctermfg=124 guifg=#af0000
highlight Number ctermfg=200 guifg=#ff00d7
highlight PreCondit ctermfg=124 guifg=#af0000
highlight Repeat ctermfg=124 guifg=#af0000
highlight SpecialComment ctermfg=27 guifg=#005fff
highlight Statement ctermfg=124 guifg=#af0000
highlight StorageClass ctermfg=124 guifg=#af0000
highlight String ctermfg=200 guifg=#ff00d7
highlight Structure ctermfg=124 guifg=#af0000
highlight Todo ctermfg=69 gui=bold guifg=#5f87ff
highlight Type ctermfg=124 guifg=#af0000
highlight Typedef ctermfg=124 guifg=#af0000
