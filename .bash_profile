OS=$(uname -s)

export RBENV_ROOT=${HOME}/.rbenv
export MANPATH=/usr/share/man:/usr/local/share/man:${HOME}/.dotfiles/extra/z
export GOPATH=$HOME GIMME_SILENT_ENV=1 GIMME_TYPE=binary

export PATH=$GOPATH/bin:$RBENV_ROOT/shims:${HOME}/.dotfiles/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:${HOME}/.config/yarn/global/node_modules/.bin:/usr/local/share/npm/bin:$PATH
export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$DYLD_LIBRARY_PATH
export PATH=$PATH:$(gcloud info --format="value(installation.sdk_root)")/bin

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1

[ -f ${HOME}/.dotfiles/extra/z/z.sh ] && source ${HOME}/.dotfiles/extra/z/z.sh

export EDITOR=vim PAGER=less MANPAGER=less

source ${HOME}/.dotfiles/extra/virtualenv
source ${HOME}/.dotfiles/extra/gpg-agent

source ${HOME}/.dotfiles/extra/chapel
source ${HOME}/.dotfiles/extra/functions

[ -f ${HOME}/.dotfiles/extra/local-functions ] && source ${HOME}/.dotfiles/extra/local-functions
[ -f ${HOME}/.dotfiles/extra/${OS}-functions ] && source ${HOME}/.dotfiles/extra/${OS}-functions

export PS1="% "
source ~/.gimme/envs/gotip.env
