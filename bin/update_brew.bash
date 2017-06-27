#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD neovim

brew cleanup -s
brew cask cleanup
brew services cleanup
brew prune
