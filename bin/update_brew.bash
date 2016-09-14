#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-release neovim/neovim/neovim
brew reinstall --HEAD universal-ctags/universal-ctags/universal-ctags

brew cask update
brew cleanup -s
brew services cleanup
