func! Multiple_cursors_before()
	call LanguageClient#isAlive(function('LC_stop'))
endfunc

func! Multiple_cursors_after()
	call LC_restart({'result': v:false})
endfunc
