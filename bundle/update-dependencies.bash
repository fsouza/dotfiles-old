#!/usr/bin/env bash

pushd ..
git submodule foreach 'git fetch origin && git rebase origin/master && git submodule update --init'
popd
