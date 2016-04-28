#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-release neovim
brew cask list | xargs brew cask install

brew cleanup -s
