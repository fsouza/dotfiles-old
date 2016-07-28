" Vim color file
" Maintainer:	Francisco Souza <f@souza.cc>
" Last Change:	2016 Apr 18

set background=light
highlight clear
if exists('syntax_on')
  syntax reset
endif

let colors_name = 'boring'

highlight Conceal term=NONE cterm=NONE ctermbg=NONE
highlight Directory term=NONE cterm=NONE ctermbg=NONE ctermfg=59
highlight ErrorMsg term=NONE cterm=NONE ctermbg=160 ctermfg=231
highlight LineNr term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight MatchParen term=NONE cterm=NONE ctermbg=145 ctermfg=NONE
highlight ModeMsg term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight MoreMsg term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight NonText term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Pmenu term=NONE cterm=NONE ctermbg=145 ctermfg=NONE
highlight PmenuSel term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Search term=NONE cterm=NONE ctermbg=52 ctermfg=231
highlight SpecialKey term=NONE cterm=NONE ctermbg=NONE ctermfg=59
highlight SpellBad term=NONE cterm=NONE ctermbg=196 ctermfg=231
highlight TabLine term=NONE cterm=NONE ctermbg=145 ctermfg=59
highlight TabLineSel term=NONE cterm=NONE ctermbg=231 ctermfg=59
highlight TabLineFill term=NONE cterm=NONE ctermbg=145 ctermfg=NONE
highlight WarningMsg term=NONE cterm=None ctermbg=NONE ctermfg=52
highlight Visual term=NONE cterm=reverse ctermbg=NONE ctermfg=NONE

highlight Comment term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Constant term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight String term=NONE cterm=bold ctermbg=NONE ctermfg=NONE
highlight Character term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Number term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Boolean term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Float term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Identifier term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Function term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Statement term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Conditional term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Repeat term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Label term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Operator term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Keyword term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Exception term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight PreProc term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Include term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Define term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Macro term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight PreCondit term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Type term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight StorageClass term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Structure term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Typedef term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Special term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight SpecialChar term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Tag term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Delimiter term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight SpecialComment term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Debug term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Underlined term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Ignore term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Error term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
highlight Todo term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE

" Vim highlights
highlight vimVar term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE

" Make highligts
highlight makeIdent term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE

" Go highlights
highlight goEscapeC term=NONE cterm=bold ctermfg=NONE ctermbg=NONE

" Terraform highlights
highlight terraResourceTypeBI term=NONE cterm=bold ctermfg=NONE ctermbg=NONE

" JSON highlights
highlight jsonKeyword term=NONE cterm=bold ctermfg=NONE ctermbg=NONE
