" Vim color file
" Maintainer:	Francisco Souza <f@souza.cc>
" Last Change:	2017 Jan 09

set background=light
highlight clear
if exists('syntax_on')
  syntax reset
endif

runtime colors/boring.vim

let g:colors_name = 'talk'

highlight Boolean term=NONE cterm=NONE ctermbg=NONE ctermfg=200 gui=NONE guibg=NONE guifg=#ff00d7
highlight Character term=NONE cterm=NONE ctermbg=NONE ctermfg=200 gui=NONE guibg=NONE guifg=#ff00d7
highlight Comment term=NONE cterm=NONE ctermbg=NONE ctermfg=27 gui=NONE guibg=NONE guifg=#005fff
highlight Conditional term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight Float term=NONE cterm=NONE ctermbg=NONE ctermfg=200 gui=NONE guibg=NONE guifg=#ff00d7
highlight Include term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight Keyword term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight Number term=NONE cterm=NONE ctermbg=NONE ctermfg=200 gui=NONE guibg=NONE guifg=#ff00d7
highlight PreCondit term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight Repeat term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight SpecialComment term=NONE cterm=NONE ctermbg=NONE ctermfg=27 gui=NONE guibg=NONE guifg=#005fff
highlight Statement term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight StorageClass term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight String term=NONE cterm=NONE ctermbg=NONE ctermfg=200 gui=NONE guibg=NONE guifg=#ff00d7
highlight Todo term=NONE cterm=NONE ctermbg=NONE ctermfg=27 gui=bold guibg=NONE guifg=#005fff
highlight Type term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
highlight Typedef term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE guifg=NONE
