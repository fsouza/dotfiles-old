# on mac, coreutils is needed to get realpath.
basedir=$(dirname $(realpath $BASH_SOURCE))
source ${basedir}/extra/init-functions

export NVM_DIR="$HOME/.nvm"
export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:/home/linuxbrew/.linuxbrew/share/man:${basedir}/extra/z
export GOPATH=${HOME} GIMME_SILENT_ENV=1 GIMME_TYPE=binary
export GOPROXY=https://proxy.golang.org,direct
export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"

export PATH=/usr/bin:/bin:/usr/sbin:/sbin
prepend_to_path \
	${basedir}/extra/gimme \
	/usr/local/sbin \
	/usr/local/bin \
	/home/linuxbrew/.linuxbrew/sbin \
	/home/linuxbrew/.linuxbrew/bin \
	${HOME}/.cargo/bin \
	${RBENV_ROOT}/shims \
	${HOME}/.local/bin \
	${HOME}/Applications/google-cloud-sdk/bin \
	${basedir}/bin \
	${GOPATH}/bin

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1

export EDITOR=nvim PAGER=less MANPAGER=less

source ${basedir}/extra/virtualenv
source ${basedir}/extra/gpg-agent

source ${basedir}/extra/chapel
source ${basedir}/extra/functions
source ${basedir}/extra/brew
source ${basedir}/extra/neovim

cond_source "${basedir}/extra/local-functions"
cond_source "${basedir}/extra/${OS_NAME}-functions"
cond_source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
cond_source "$NVM_DIR/nvm.sh"
cond_source "${HOME}/.gimme/envs/gotip.env"
cond_source "${basedir}/extra/z/z.sh"

export PS1="％ " PS2="≫ "

if [ -n "$(which opam)" ]; then
	eval $(opam env)
fi

source ${basedir}/extra/tmux
unset basedir
