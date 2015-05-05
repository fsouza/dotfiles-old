export LANG=en_US.UTF-8
export LC_COLLATE=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=pt_BR.UTF-8
export LC_NUMERIC=pt_BR.UTF-8
export LC_TIME=pt_BR.UTF-8

export GOROOT=${HOME}/opt/src/go
export GOPATH=${HOME}
export RBENV_ROOT=/usr/local/var/rbenv

export MANPATH=/usr/share/man:/usr/local/share/man:$HOME/opt/src/qthread/man
export NODE_PATH=/usr/local/lib/node_modules
export NODE_MODULES=/usr/local/lib/node_modules

export PATH=$RBENV_ROOT/shims:${HOME}/opt/bin:${GOROOT}/bin:${GOPATH}/bin:/usr/local/bin:/usr/local/sbin:${path}:${HOME}/Projects/dotfiles/bin:/usr/local/share/npm/bin:${HOME}/opt/src/x10-code/x10.dist/bin:$PATH

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

export EDITOR=vim PAGER=less MANPAGER=less
export HOMEBREW_MAKE_JOBS=4 HOMEBREW_BUILD_FROM_SOURCE=1

export FC=/usr/local/bin/gfortran-5

source ${HOME}/Projects/dotfiles/extra/virtualenv
alias dr="rm $RBENV_ROOT/version"

export MONO_GAC_PREFIX="/usr/local"

export PS1="% "

pushd ${HOME}/opt/src/chapel-code > /dev/null && source util/setchplenv.bash > /dev/null && popd > /dev/null
export CHPL_TARGET_ARCH=native CHPL_REGEXP=re2 CHPL_AUX_FILESYS=curl CHPL_DEVELOPER=1
export CHPL_MODULE_PATH=${HOME}/Projects/chapel-modules
