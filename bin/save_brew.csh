#!/bin/csh -e

brew list > "$1"
brew tap > "${1}"-tap
