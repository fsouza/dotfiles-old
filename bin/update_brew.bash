#!/bin/bash -le

brew update
brew upgrade

brew cleanup -s
brew cask cleanup
brew services cleanup
brew prune
