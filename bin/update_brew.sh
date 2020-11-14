#!/bin/zsh -le

brew update
brew upgrade

brew cleanup -s --prune 3
if [[ ${OSTYPE} == darwin* ]]; then
	brew services cleanup
fi
