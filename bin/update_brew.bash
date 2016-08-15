#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-release neovim/neovim/neovim

brew cask update
brew cleanup -s
brew services cleanup
