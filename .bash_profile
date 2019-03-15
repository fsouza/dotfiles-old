function cond_source {
	[ -s "${1}" ] && source "${1}"
}

export OS_NAME=$(uname -s)
export NVM_DIR="$HOME/.nvm"
export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z
export GOPATH=$HOME GIMME_SILENT_ENV=1 GIMME_TYPE=binary

export PATH=$GOPATH/bin:$RBENV_ROOT/shims:${HOME}/.dotfiles/bin:${HOME}/.cargo/bin:/home/linuxbrew/.linuxbrew:/usr/local/bin:/usr/local/sbin:${HOME}/.dotfiles/extra/gimme:$PATH

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1

export EDITOR=nvim PAGER=less MANPAGER=less

source ${HOME}/.dotfiles/extra/virtualenv
source ${HOME}/.dotfiles/extra/gpg-agent

source ${HOME}/.dotfiles/extra/chapel
source ${HOME}/.dotfiles/extra/functions

cond_source "${HOME}/.dotfiles/extra/z/z.sh"
cond_source "${HOME}/.dotfiles/extra/local-functions"
cond_source "${HOME}/.dotfiles/extra/${OS_NAME}-functions"
cond_source /usr/local/etc/bash_completion
cond_source "/home/linuxbrew/.linuxbrew/etc/bash_completion"
cond_source "$NVM_DIR/nvm.sh"
cond_source "${HOME}/.gimme/envs/gotip.env"

export PS1="％ "
eval $(opam env)

source ${HOME}/.dotfiles/extra/tmux
