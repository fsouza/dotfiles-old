#!/bin/bash -le

brew update
brew upgrade

brew cleanup -s --prune 3
brew services cleanup
