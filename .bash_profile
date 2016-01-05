export LANG=en_US.UTF-8
export LC_COLLATE=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=pt_BR.UTF-8
export LC_NUMERIC=pt_BR.UTF-8
export LC_TIME=pt_BR.UTF-8

OS=$(uname -s)

export GOPATH=${HOME} GO15VENDOREXPERIMENT=1
export SCALA_HOME=${HOME}/opt/scala

export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z

export PATH=$RBENV_ROOT/shims:${HOME}/opt/bin:${GOPATH}/bin:${SCALA_HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:${HOME}/.dotfiles/extra/gimme:$PATH

export EDITOR=vim PAGER=less MANPAGER=less
export HOMEBREW_MAKE_JOBS=4

source ${HOME}/.dotfiles/extra/virtualenv
alias dr="rm $RBENV_ROOT/version"

export PS1="% "

if [ -d ${HOME}/opt/src/chapel-code ]; then
	pushd ${HOME}/opt/src/chapel-code > /dev/null && source util/setchplenv.bash > /dev/null && popd > /dev/null
	export CHPL_TARGET_ARCH=native CHPL_REGEXP=re2 CHPL_AUX_FILESYS=curl CHPL_DEVELOPER=1
	export CHPL_MODULE_PATH=${HOME}/Projects/chapel-modules
fi

source ${HOME}/.dotfiles/extra/functions

[ -f ${HOME}/.dotfiles/extra/local-functions ] && source ${HOME}/.dotfiles/extra/local-functions
[ -f ${HOME}/.dotfiles/extra/${OS}-functions ] && source ${HOME}/.dotfiles/extra/${OS}-functions

. ${HOME}/.dotfiles/extra/z/z.sh

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export GIMME_SILENT_ENV=1 GIMME_TYPE=binary
