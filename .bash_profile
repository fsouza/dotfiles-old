OS=$(uname -s)

export NVM_DIR="$HOME/.nvm"
export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z
export GOPATH=$HOME

export PATH=$GOPATH/bin:$RBENV_ROOT/shims:${HOME}/.dotfiles/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:${PATH}
export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:${LD_LIBRARY_PATH}
export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib:${DYLD_LIBRARY_PATH}

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1

[ -f ${HOME}/.dotfiles/extra/z/z.sh ] && source ${HOME}/.dotfiles/extra/z/z.sh

export EDITOR=vim PAGER=less MANPAGER=less

source ${HOME}/.dotfiles/extra/virtualenv
source ${HOME}/.dotfiles/extra/gpg-agent

source ${HOME}/.dotfiles/extra/functions
source /usr/local/opt/nvm/nvm.sh

[ -f ${HOME}/.dotfiles/extra/local-functions ] && source ${HOME}/.dotfiles/extra/local-functions
[ -f ${HOME}/.dotfiles/extra/${OS}-functions ] && source ${HOME}/.dotfiles/extra/${OS}-functions

export PS1="% "
