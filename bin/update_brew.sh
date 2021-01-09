#!/usr/bin/env bash

set -euo pipefail

brew update
brew upgrade

brew cleanup -s --prune 3
if [[ ${OSTYPE} == darwin* ]]; then
	brew services cleanup
fi
