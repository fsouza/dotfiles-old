setenv LANG en_US.UTF-8
setenv LC_COLLATE pt_BR.UTF-8
setenv LC_CTYPE pt_BR.UTF-8
setenv LC_MESSAGES en_US.UTF-8
setenv LC_MONETARY pt_BR.UTF-8
setenv LC_NUMERIC pt_BR.UTF-8
setenv LC_TIME pt_BR.UTF-8

setenv GOROOT ${HOME}/lib/go
setenv GOPATH ${HOME}/gocode
setenv PLAN9 ${HOME}/lib/plan9port
setenv RBENV ${HOME}/.rbenv

setenv NODE_PATH /usr/local/lib/node_modules

set path=($RBENV/shims $HOME/bin /opt/bin ${GOROOT}/bin ${GOPATH}/bin /usr/local/bin /usr/local/sbin /opt/local/bin ${path} ${HOME}/Projects/dotfiles/bin $PLAN9/bin)

setenv JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home

setenv EDITOR vim
setenv PAGER less
setenv MANPAGER $PAGER

setenv CC /opt/bin/clang
setenv CXX /opt/bin/clang++
setenv CFLAGS "-Wall -Wextra -Wno-comments -pedantic"
setenv C_INCLUDE_PATH /usr/local/include:/opt/include
setenv CXXFLAGS "${CFLAGS}"
setenv CPLUS_INCLUDE_PATH /opt/include/libcxx:/usr/local/include:/opt/include
setenv LIBRARY_PATH /usr/local/lib:/opt/lib
setenv DYLD_LIBRARY_PATH /opt/lib/libcxx:/opt/lib
setenv VIRTUALENVS ${HOME}/.venvs

if $?SSH_CLIENT then
	set machine="ssh=%m/"
else
	set machine=""
endif

alias v "source ${HOME}/Projects/dotfiles/extra/activate_virtualenv.csh"
alias d "source ${HOME}/Projects/dotfiles/extra/deactivate_virtualenv.csh"
alias mkv "test -d ${VIRTUALENVS} || mkdir -p ${VIRTUALENVS} ; virtualenv ${VIRTUALENVS}/\!:1"
alias rmv "rm -rf ${VIRTUALENVS}/\!:1 && echo 'Removed ${VIRTUALENVS}/\!:1'"
alias rbenv_version "cat $RBENV/version >& /dev/null && cat $RBENV/version | sed -e 's/^.*\(1.[0-9].[0-9]\).*/r=\1 /'"
alias dr "rm $RBENV/version"
alias disable-push "cp ${HOME}/Projects/dotfiles/extra/pre-push .git/hooks/pre-push"
alias enable-push "rm .git/hooks/pre-push"

alias setprompt 'set prompt="${machine}$cwd:t% "'
alias precmd setprompt
setprompt

source /opt/intel/bin/compilervars.csh intel64
