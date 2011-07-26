autocmd filetype css setlocal equalprg=csstidy\ -\ --silent=true\ --template=$VIMHOME/ftdetect/csstidy.tpl\ --sort_properties=true\ --sort_selectors=true\ --compress_font-weight=false
autocmd filetype css map <C-c> :call MakeCSSInline()<CR>

fun MakeCSSInline()
    exec 'r!csstidy % --silent=true --template=high --sort_properties=true --sort_selectors=true --compress_font-weight=false %'
    exec ':edit!'
endfun
