#!/bin/bash -e

ROOT=$(cd `dirname ${0}` && pwd -P)

function init {
	git submodule update --init --recursive
}

function install_java_server {
	pushd "$ROOT/langservers/jdtls"
	./mvnw package
	popd
}

function install_yaml_server {
	pushd "$ROOT/langservers/yaml-language-server"
	npm ci
	npm run compile
	popd
}

function install_servers_from_npm {
	npm i -g ocaml-language-server typescript-language-server dockerfile-language-server-nodejs vscode-css-languageserver-bin bash-language-server
}

init
install_java_server
install_yaml_server
install_servers_from_npm
