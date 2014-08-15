#!/usr/bin/env csh

pushd ..
git submodule foreach 'git fetch origin && git rebase origin/master && git submodule update --init'
git submodule update --init --recursive
popd
