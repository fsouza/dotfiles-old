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
highlight Conditional cterm=bold gui=bold
highlight Float ctermfg=200 guifg=#ff00d7
highlight Include cterm=bold gui=bold
highlight Keyword cterm=bold gui=bold
highlight Number ctermfg=200 guifg=#ff00d7
highlight PreCondit cterm=bold gui=bold
highlight Repeat cterm=bold gui=bold
highlight SpecialComment ctermfg=27 guifg=#005fff
highlight Statement cterm=bold gui=bold
highlight StorageClass cterm=bold gui=bold
highlight String ctermfg=200 guifg=#ff00d7
highlight Todo ctermfg=27 gui=bold guifg=#005fff
highlight Type cterm=bold gui=bold
highlight Typedef cterm=bold gui=bold
