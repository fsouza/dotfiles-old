OS=$(uname -s)

export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z
export GOPATH=$HOME GIMME_SILENT_ENV=1 GIMME_TYPE=binary

export PATH=$GOPATH/bin:$RBENV_ROOT/shims:${HOME}/opt/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:${HOME}/.dotfiles/extra/gimme:$PATH

[ -f ${HOME}/.dotfiles/extra/z/z.sh ] && source ${HOME}/.dotfiles/extra/z/z.sh

export EDITOR=nvim PAGER=less MANPAGER=less

source ${HOME}/.dotfiles/extra/virtualenv
source ${HOME}/.dotfiles/extra/gpg-agent

source ${HOME}/.dotfiles/extra/chapel
source ${HOME}/.dotfiles/extra/functions

[ -f ${HOME}/.dotfiles/extra/local-functions ] && source ${HOME}/.dotfiles/extra/local-functions
[ -f ${HOME}/.dotfiles/extra/${OS}-functions ] && source ${HOME}/.dotfiles/extra/${OS}-functions

export PS1="% "
gimme 1.8rc1
