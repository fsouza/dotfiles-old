#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-release neovim

brew cleanup -s
