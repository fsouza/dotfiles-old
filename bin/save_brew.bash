#!/bin/bash -el

brew leaves > "$1"
brew tap > "${1}"-tap
brew cask list > "${1}-cask"
