#!/bin/bash -el

brew leaves > "$1"
brew tap > "${1}"-tap
