" Language: PHP
" Maintainer: Mikolaj Machowski <mikmach@wp.pl>
" Last Change: pon lip 01 11:00  2002 C

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal include=\\\(require\\\|include\\\)\\\(_once\\\)\\\?
setlocal iskeyword+=$
setlocal formatoptions-=t
setlocal formatoptions+=croql
setlocal comments=sr:/*,mb:*,ex:*/,://,b:#
setlocal define=define
 
compiler php

setlocal cindent
setlocal cinkeys=0{,0},:,!^F,o,O,e
setlocal cinoptions=:1s,p1s,t0,)40,*40
setlocal cinwords=if,elseif,else,while,do,for,foreach,switch,case
setlocal matchpairs=(:),{:},[:]

let b:match_words = '\<switch\>:\<endswitch\>,' .
                  \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
				  \ '\<while\>:\<endwhile\>,' .
				  \ '\<do\>:\<while\>,' .
				  \ '\<for\>:\<endfor\>,' .
				  \ '\<foreach\>:\<endforeach\>'

" Private part
"setlocal showmatch
"setlocal shellpipe=>
"let b:closetag_html_style=1
"let php_sql_query="1"
"let php_htmlInStrings="1"
"let php_folding="1"
"syntax sync fromstart
"setlocal dictionary+=$HOME/.vim/dictionaries/phpfunclist
"setlocal dictionary+=$HOME/.vim/dictionaries/phpproto
"setlocal keywordprg=$HOME/.vim/external/phpmanual.sh
"iab <? <?php
