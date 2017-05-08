autocmd FileType d setlocal softtabstop=4 expandtab

call dutyl#register#tool('dcd-client', ['dcd-client', '--tcp'])
call dutyl#register#tool('dcd-server', ['dcd-server', '--tcp'])

let g:dutyl_stdImportPaths=['/usr/local/include/dlang/dmd']
let g:dutyl_neverAddClosingParen=1
