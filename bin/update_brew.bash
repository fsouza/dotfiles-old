#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-override-system-vi vim

brew cleanup -s
