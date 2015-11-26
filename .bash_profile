export LANG=en_US.UTF-8
export LC_COLLATE=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=pt_BR.UTF-8
export LC_NUMERIC=pt_BR.UTF-8
export LC_TIME=pt_BR.UTF-8

OS=$(uname -s)

export GOPATH=${HOME} GO15VENDOREXPERIMENT=1
export RBENV_ROOT=/usr/local/var/rbenv

export MANPATH=/usr/share/man:/usr/local/share/man
export NODE_PATH=/usr/local/lib/node_modules
export NODE_MODULES=/usr/local/lib/node_modules

export PATH=$RBENV_ROOT/shims:${HOME}/opt/bin:${GOPATH}/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:${HOME}/opt/src/x10-code/x10.dist/bin:$PATH

export EDITOR=vim PAGER=less MANPAGER=less

if [ "${OS}" = "Darwin" ]; then
	export HOMEBREW_MAKE_JOBS=4
	source ${HOME}/Projects/dotfiles/extra/ntfs
fi

source ${HOME}/Projects/dotfiles/extra/virtualenv
alias dr="rm $RBENV_ROOT/version"

export PS1="% "

if [ -d ${HOME}/opt/src/chapel-code ]; then
	pushd ${HOME}/opt/src/chapel-code > /dev/null && source util/setchplenv.bash > /dev/null && popd > /dev/null
	export CHPL_TARGET_ARCH=native CHPL_REGEXP=re2 CHPL_AUX_FILESYS=curl CHPL_DEVELOPER=1
	export CHPL_MODULE_PATH=${HOME}/Projects/chapel-modules
fi

source ${HOME}/Projects/dotfiles/extra/functions

if [ -f ${HOME}/Projects/dotfiles/extra/local-functions ]; then
	source ${HOME}/Projects/dotfiles/extra/local-functions
fi

. ${HOME}/Projects/dotfiles/extra/z/z.sh
