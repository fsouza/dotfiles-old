#!/bin/bash -le

brew update
brew upgrade

brew reinstall --HEAD --with-python3 --with-override-system-vi vim

brew cleanup -s
