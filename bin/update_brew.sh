#!/bin/zsh -le

brew update
brew upgrade

brew cleanup -s --prune 3
if [[ $OS_NAME == "Darwin" ]]; then
	brew services cleanup
fi
