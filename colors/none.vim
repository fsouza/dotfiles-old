set background=light
highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'none'

highlight Conceal cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight CursorLine cterm=NONE ctermbg=253 ctermfg=NONE gui=NONE guibg=#dadada guifg=NONE
highlight CursorLineNr cterm=bold ctermbg=253 ctermfg=NONE gui=bold guibg=#dadada guifg=NONE
highlight Directory cterm=NONE ctermbg=NONE ctermfg=59 gui=NONE guibg=NONE guifg=#5f5f5f
highlight ErrorMsg cterm=NONE ctermbg=160 ctermfg=231 gui=NONE guibg=#d70000 guifg=#ffffff
highlight LineNr cterm=NONE ctermbg=253 ctermfg=NONE gui=NONE guibg=#dadada guifg=NONE
highlight MatchParen cterm=NONE ctermbg=145 ctermfg=NONE gui=NONE guibg=#afafaf guifg=NONE
highlight ModeMsg cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight MoreMsg cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
highlight Normal cterm=NONE ctermbg=NONE ctermfg=235 gui=NONE guibg=NONE guifg=#262626
highlight NonText cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Pmenu cterm=NONE ctermbg=145 ctermfg=NONE gui=NONE guibg=#afafaf guifg=NONE
highlight PmenuSbar cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight PmenuSel cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight PmenuThumb cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Question cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Search cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight SignColumn cterm=NONE ctermbg=253 ctermfg=232 gui=NONE guibg=#dadada guifg=#080808
highlight SpecialKey cterm=NONE ctermbg=NONE ctermfg=59 gui=NONE guibg=NONE guifg=#5f5f5f
highlight SpellBad cterm=NONE ctermbg=NONE ctermfg=196 gui=NONE guibg=NONE guifg=#ff0000
highlight StatusLine cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
highlight StatusLineNC cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
highlight TabLine cterm=NONE ctermbg=145 ctermfg=59 gui=NONE guibg=#afafaf guifg=#5f5f5f
highlight TabLineFill cterm=NONE ctermbg=145 ctermfg=NONE gui=NONE guibg=#afafaf guifg=NONE
highlight TabLineSel cterm=NONE ctermbg=NONE ctermfg=59 gui=NONE guibg=NONE guifg=#5f5f5f
highlight Title cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Visual cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
highlight WarningMsg cterm=None ctermbg=NONE ctermfg=52 gui=None guibg=NONE guifg=#5f0000

highlight Boolean cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Character cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Comment cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Conditional cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Constant cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Debug cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Define cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Delimiter cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Error cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Exception cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Float cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Function cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Identifier cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Ignore cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Include cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Keyword cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Label cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Macro cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Number cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Operator cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight PreCondit cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight PreProc cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Repeat cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Special cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight SpecialChar cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight SpecialComment cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Statement cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight StorageClass cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight String cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Structure cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Tag cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Todo cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Type cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Typedef cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE
highlight Underlined cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE

highlight htmlBold cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=NONE

highlight LspReferenceText cterm=NONE ctermbg=252 ctermfg=NONE gui=NONE guibg=#5f0000 guifg=NONE
highlight LspReferenceRead cterm=NONE ctermbg=252 ctermfg=NONE gui=NONE guibg=#5f0000 guifg=NONE
highlight LspReferenceWrite cterm=NONE ctermbg=252 ctermfg=NONE gui=NONE guibg=#5f0000 guifg=NONE

highlight LspDiagnosticsError cterm=NONE ctermbg=NONE ctermfg=248 gui=NONE guibg=NONE guifg=#a8a8a8
highlight LspDiagnosticsErrorSign cterm=NONE ctermbg=253 ctermfg=235 gui=NONE guibg=#dadada guifg=#262626
highlight LspDiagnosticsWarning cterm=NONE ctermbg=NONE ctermfg=248 gui=NONE guibg=NONE guifg=#a8a8a8
highlight LspDiagnosticsWarningSign cterm=NONE ctermbg=253 ctermfg=235 gui=NONE guibg=#dadada guifg=#262626
highlight LspDiagnosticsInformation cterm=NONE ctermbg=NONE ctermfg=248 gui=NONE guibg=NONE guifg=#a8a8a8
highlight LspDiagnosticsInformationSign cterm=NONE ctermbg=253 ctermfg=235 gui=NONE guibg=#dadada guifg=#262626
highlight LspDiagnosticsHint cterm=NONE ctermbg=NONE ctermfg=248 gui=NONE guibg=NONE guifg=#a8a8a8
highlight LspDiagnosticsHintSign cterm=NONE ctermbg=253 ctermfg=235 gui=NONE guibg=#dadada guifg=#262626

highlight StatusLine cterm=NONE ctermbg=238 ctermfg=231 gui=NONE guibg=#444444 guifg=#ffffff
highlight StatusLineNC cterm=NONE ctermfg=238 ctermbg=252 gui=NONE guifg=#444444 guibg=#5f0000

highlight HlYank cterm=NONE ctermbg=225 ctermfg=NONE gui=NONE guibg=#ffd7ff guifg=NONE
highlight netrwMarkfile cterm=bold gui=bold
