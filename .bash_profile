OS=$(uname -s)

export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z

export PATH=$RBENV_ROOT/shims:${HOME}/opt/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:${HOME}/.dotfiles/extra/gimme:$PATH

export EDITOR=nvim PAGER=less MANPAGER=less

source ${HOME}/.dotfiles/extra/virtualenv
source ${HOME}/.dotfiles/extra/gpg-agent
alias dr="rm $RBENV_ROOT/version"

if [ -n "${SSH_CLIENT}" ]; then
	export PS1="[\h] % "
else
	export PS1="% "
fi

source ${HOME}/.dotfiles/extra/chapel
source ${HOME}/.dotfiles/extra/functions

[ -f ${HOME}/.dotfiles/extra/local-functions ] && source ${HOME}/.dotfiles/extra/local-functions
[ -f ${HOME}/.dotfiles/extra/${OS}-functions ] && source ${HOME}/.dotfiles/extra/${OS}-functions

. ${HOME}/.dotfiles/extra/z/z.sh

export GIMME_SILENT_ENV=1 GIMME_TYPE=binary
gimme 1.6.2

export GOPATH=${HOME} GO15VENDOREXPERIMENT=1
export PATH=${GOPATH}/bin:${PATH}
