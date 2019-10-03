#!/bin/zsh -el

basedir=$(cd $(dirname $0)/..; pwd -P)

brew info --installed --json | jq -rf $basedir/extra/brew-info.jq > "$1"

brew tap > "${1}-tap"
if [[ ${OS_NAME} == "Darwin" ]]; then
	brew cask list > "${1}-cask"
fi
