setenv LANG en_US.UTF-8
setenv LC_COLLATE pt_BR.UTF-8
setenv LC_CTYPE pt_BR.UTF-8
setenv LC_MESSAGES en_US.UTF-8
setenv LC_MONETARY pt_BR.UTF-8
setenv LC_NUMERIC pt_BR.UTF-8
setenv LC_TIME pt_BR.UTF-8

setenv GOROOT ${HOME}/lib/go
setenv GOPATH ${HOME}/gocode
setenv RBENV_ROOT /usr/local/var/rbenv

setenv PYTHONPATH /usr/local/lib/python2.7/site-packages
setenv MANPATH /usr/share/man:/usr/local/share/man:/usr/local/opt/erlang/lib/erlang/man
setenv NODE_PATH /usr/local/lib/node_modules
setenv NODE_MODULES /usr/local/lib/node_modules
setenv ANDROID_HOME /usr/local/opt/android-sdk

set path=($RBENV_ROOT/shims ${HOME}/opt/bin ${GOROOT}/bin ${GOPATH}/bin /usr/local/bin /usr/local/sbin ${path} ${HOME}/Projects/dotfiles/bin /usr/local/share/npm/bin)

setenv JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home

setenv EDITOR vim
setenv PAGER less
setenv MANPAGER $PAGER

setenv HOMEBREW_MAKE_JOBS 4

setenv FC /usr/local/bin/gfortran-4.9
setenv CC $HOME/opt/bin/clang
setenv CXX $HOME/opt/bin/clang++
setenv CPPFLAGS "-I$HOME/opt/include -I/usr/include -I/usr/local/include"
setenv LIBRARY_PATH $HOME/opt/lib:/usr/local/lib
setenv VIRTUALENVS ${HOME}/.venvs

alias v "source ${HOME}/Projects/dotfiles/extra/activate_virtualenv.csh"
alias d "source ${HOME}/Projects/dotfiles/extra/deactivate_virtualenv.csh"
alias cv "which python"
alias mkv "test -d ${VIRTUALENVS} || mkdir -p ${VIRTUALENVS} ; virtualenv-2.7 ${VIRTUALENVS}/\!:1"
alias rmv "rm -rf ${VIRTUALENVS}/\!:1 && echo 'Removed ${VIRTUALENVS}/\!:1'"
alias dr "rm $RBENV_ROOT/version"

set prompt="% "

pushd ${HOME}/lib/chapel > /dev/null && source util/setchplenv.csh > /dev/null && popd > /dev/null

source /opt/intel/bin/compilervars.csh intel64
