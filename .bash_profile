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

export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export MANPATH=/usr/share/man:/usr/local/share/man:$HOME/opt/src/qthread/man
export NODE_PATH=/usr/local/lib/node_modules
export NODE_MODULES=/usr/local/lib/node_modules
export ANDROID_HOME=/usr/local/opt/android-sdk

export PATH=$RBENV_ROOT/shims:${HOME}/opt/bin:${GOROOT}/bin:${GOPATH}/bin:/usr/local/bin:/usr/local/sbin:${path}:${HOME}/Projects/dotfiles/bin:/usr/local/share/npm/bin:${HOME}/opt/src/x10-code/x10.dist/bin:$PATH

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home

export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER

export HOMEBREW_MAKE_JOBS=4
export HOMEBREW_BUILD_FROM_SOURCE=1

export FC=/usr/local/bin/gfortran-5
export CC=$HOME/opt/bin/clang CXX=$HOME/opt/bin/clang++
export CPPFLAGS="-I$HOME/opt/include=-I/usr/include=-I/usr/local/include"
export LIBRARY_PATH=$HOME/opt/lib:/usr/local/lib

source ${HOME}/Projects/dotfiles/extra/virtualenv
alias dr="rm $RBENV_ROOT/version"

export PS1="% "

pushd ${HOME}/opt/src/chapel-code > /dev/null && source util/setchplenv.bash > /dev/null && popd > /dev/null
export QT_GUARD_PAGES=no
export CHPL_TARGET_ARCH=native CHPL_REGEXP=re2 CHPL_AUX_FILESYS=curl
export CHPL_MODULE_PATH=${HOME}/Projects/chapel-modules

source /opt/intel/bin/compilervars.sh intel64
