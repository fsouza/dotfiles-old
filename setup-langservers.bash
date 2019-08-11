#!/bin/bash

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

function install_fsharp_server {
	if [ -z "$(which dotnet)" ]; then
		echo skipping fsharp-language-server
		return
	fi
	pushd "$ROOT/langservers/fsharp-language-server"
	npm ci
	dotnet build -c Release
	popd
}

function install_merlin_lsp {
	if [ -z "$(which opam)" ]; then
		echo skipping merlin-lsp
		return
	fi
	opam pin merlin-lsp.dev https://github.com/ocaml/merlin.git -y
}

function install_servers_from_npm {
	npm i --no-save \
		dockerfile-language-server-nodejs \
		javascript-typescript-langserver \
		typescript-language-server \
		vscode-css-languageserver-bin \
		vscode-html-languageserver-bin \
		vscode-json-languageserver-bin
}

pushd $ROOT
init
install_java_server
install_yaml_server
install_fsharp_server
install_merlin_lsp
install_servers_from_npm
popd
