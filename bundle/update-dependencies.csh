#!/usr/bin/env csh

pushd ..
git submodule foreach 'git pull origin master && git submodule update --init'
popd
