#!/bin/bash -el

brew leaves > "$1"
brew cask list > "${1}-cask"
