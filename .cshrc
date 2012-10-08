setenv LANG en_US.UTF-8
setenv LC_COLLATE pt_BR.UTF-8
setenv LC_CTYPE pt_BR.UTF-8
setenv LC_MESSAGES en_US.UTF-8
setenv LC_MONETARY pt_BR.UTF-8
setenv LC_NUMERIC pt_BR.UTF-8
setenv LC_TIME pt_BR.UTF-8

setenv GOROOT ${HOME}/lib/go
setenv GOPATH ${HOME}/gocode
setenv GOMAXPROCS 1
setenv RBENV $HOME/.rbenv
setenv PLAN9 $HOME/lib/plan9port

setenv NODE_PATH /usr/local/lib/node_modules

setenv ANDROID_SDK /opt/local/android-sdk-macosx

set path=($RBENV/shims /usr/local/bin /usr/local/sbin ${GOROOT}/bin ${GOPATH}/bin /opt/local/bin ${ANDROID_SDK}/tools ${ANDROID_SDK}/platform-tools ${path} ${HOME}/Projects/dotfiles/bin ${PLAN9}/bin)
set history=50

setenv EDITOR vim
setenv PAGER less
setenv MANPAGER ${PAGER}

setenv CC /usr/bin/clang
setenv CXX /usr/bin/clang++
setenv CFLAGS "-I/usr/local/include/ -Wall -Wextra -Werror -pedantic"
setenv CXXFLAGS "${CFLAGS}"
setenv LDFLAGS "-L/usr/local/lib/"
setenv VIRTUALENVS ${HOME}/.venvs

set machine=""

if $?SSH_CLIENT then
    set machine="ssh=%m/"
endif

alias v "source ${HOME}/Projects/dotfiles/extra/activate_virtualenv.csh"
alias d "source ${HOME}/Projects/dotfiles/extra/deactivate_virtualenv.csh"
alias mkv "test -d ${VIRTUALENVS} || mkdir -p ${VIRTUALENVS} ; virtualenv ${VIRTUALENVS}/\!:1"
alias rmv "rm -rf ${VIRTUALENVS}/\!:1 && echo 'Removed ${VIRTUALENVS}/\!:1'"
alias rbenv_version "cat $RBENV/version >& /dev/null && cat $RBENV/version | sed -e 's/^.*\(1.[0-9].[0-9]\).*/r=\1 /'"
alias dr "rm $RBENV/version"

alias setprompt 'set prompt="${machine}$cwd:t% "'
alias precmd setprompt
setprompt
