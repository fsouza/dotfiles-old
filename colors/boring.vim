" Vim color file
" Maintainer:	Francisco Souza <f@souza.cc>
" Last Change:	2016 Apr 18

set background=light
highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "boring"

highlight Visual term=NONE cterm=reverse
highlight ErrorMsg term=NONE ctermbg=1 ctermfg=7
highlight MatchParen term=NONE ctermbg=4 ctermfg=0
highlight Pmenu term=NONE ctermbg=3 ctermfg=NONE gui=NONE
