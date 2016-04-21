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
highlight ErrorMsg term=NONE cterm=NONE ctermbg=1 ctermfg=7
highlight LineNr term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight MatchParen term=NONE cterm=NONE ctermbg=15 ctermfg=NONE
highlight ModeMsg term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight MoreMsg term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight NonText term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Pmenu term=NONE cterm=NONE ctermbg=15 ctermfg=NONE
highlight Search term=NONE cterm=NONE ctermbg=3 ctermfg=7
highlight SpecialKey term=NONE cterm=NONE ctermbg=NONE ctermfg=8
highlight SpellBad term=NONE cterm=NONE ctermbg=1 ctermfg=7
highlight TabLine term=None cterm=None ctermbg=15 ctermfg=8
highlight TabLineFill term=NONE cterm=NONE ctermbg=8 ctermfg=NONE
highlight TabLineSel term=NONE cterm=NONE ctermbg=NONE ctermfg=0
highlight WarningMsg term=NONE cterm=None ctermbg=3 ctermfg=7
highlight Visual term=NONE cterm=reverse
