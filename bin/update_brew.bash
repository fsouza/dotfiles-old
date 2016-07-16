#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD vim

brew cleanup -s
