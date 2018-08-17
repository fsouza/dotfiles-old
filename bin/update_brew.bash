#!/bin/bash -le

brew update
brew upgrade

brew cleanup -s
brew services cleanup
brew prune
