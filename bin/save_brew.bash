#!/usr/bin/env bash

set -e

brew leaves > "$1"
brew tap > "${1}"-tap
