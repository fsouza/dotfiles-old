setenv LANG en_US.UTF-8
setenv LC_COLLATE pt_BR.UTF-8
setenv LC_CTYPE pt_BR.UTF-8
setenv LC_MESSAGES en_US.UTF-8
setenv LC_MONETARY pt_BR.UTF-8
setenv LC_NUMERIC pt_BR.UTF-8
setenv LC_TIME pt_BR.UTF-8

setenv GOROOT ${HOME}/lib/go
setenv GOPATH ${HOME}/gocode

setenv PYTHONPATH /usr/local/lib/python2.7/site-packages
setenv MANPATH /usr/share/man:/usr/local/share/man
setenv NODE_PATH /usr/local/lib/node_modules
setenv NODE_MODULES /usr/local/lib/node_modules

set path=(${HOME}/opt/bin ${GOROOT}/bin ${GOPATH}/bin /usr/local/bin /usr/local/sbin ${path} ${HOME}/Projects/dotfiles/bin /usr/local/share/npm/bin ${HOME}/.gem/ruby/2.0.0/bin/)

setenv JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home

setenv EDITOR vim
setenv PAGER less
setenv MANPAGER $PAGER

setenv CC $HOME/opt/bin/clang
setenv CFLAGS "-Wall -Wextra -Wno-comments -pedantic"
setenv CPPFLAGS "-I$HOME/opt/include -I/usr/include -I/usr/local/include"
setenv CXX $HOME/opt/bin/clang++
setenv CXXFLAGS "${CFLAGS}"
setenv LIBRARY_PATH $HOME/opt/lib:/usr/local/lib
setenv VIRTUALENVS ${HOME}/.venvs

if $?SSH_CLIENT then
	set machine="ssh=%m/"
else
	set machine=""
endif

alias v "source ${HOME}/Projects/dotfiles/extra/activate_virtualenv.csh"
alias d "source ${HOME}/Projects/dotfiles/extra/deactivate_virtualenv.csh"
alias mkv "test -d ${VIRTUALENVS} || mkdir -p ${VIRTUALENVS} ; virtualenv-2.7 ${VIRTUALENVS}/\!:1"
alias rmv "rm -rf ${VIRTUALENVS}/\!:1 && echo 'Removed ${VIRTUALENVS}/\!:1'"
alias disable-push "cp ${HOME}/Projects/dotfiles/extra/pre-push .git/hooks/pre-push"
alias enable-push "rm .git/hooks/pre-push"

alias setprompt 'set prompt="${machine}$cwd:t% "'
alias precmd setprompt
setprompt

pushd ${HOME}/lib/chapel > /dev/null && source util/setchplenv.csh > /dev/null && popd > /dev/null
