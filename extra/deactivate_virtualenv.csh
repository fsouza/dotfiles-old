if ($?oldpath) then
	set path=($oldpath)
	unsetenv oldpath
	unsetenv VIRTUALENV

	unalias cdvirtualenv
	unalias cdsitepackages
	rehash
else
	echo "virtualenv not active"
endif
