" Vim color file
" Maintainer:	Francisco Souza <f@souza.cc>
" Last Change:	2016 Apr 18

set background=light
highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "boring"

highlight Directory term=NONE cterm=NONE ctermbg=NONE ctermfg=8
highlight ErrorMsg term=NONE ctermbg=1 ctermfg=7
highlight MatchParen term=NONE ctermbg=8 ctermfg=0
highlight NonText term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Pmenu term=NONE ctermbg=15 ctermfg=NONE
highlight SpellBad term=NONE cterm=NONE ctermbg=1 ctermfg=7
highlight Visual term=NONE cterm=reverse
