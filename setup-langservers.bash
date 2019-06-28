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
	pushd "$ROOT/langservers/fsharp-language-server"
	npm ci
	dotnet build -c Release
	popd
}

function install_servers_from_npm {
	npm i --no-save \
		dockerfile-language-server-nodejs \
		javascript-typescript-langserver \
		ocaml-language-server \
		typescript-language-server \
		vscode-css-languageserver-bin \
		vscode-html-languageserver-bin \
		vscode-json-languageserver-bin
}

function install_scala_metals {
	coursier bootstrap \
		--java-opt -Xss4m \
		--java-opt -Xms100m \
		--java-opt -Dmetals.client=LanguageClient-neovim \
		org.scalameta:metals_2.12:0.7.0 \
		-r bintray:scalacenter/releases \
		-r sonatype:snapshots \
		-o $HOME/bin/metals-vim -f
}

pushd $ROOT
init
install_java_server
install_yaml_server
install_fsharp_server
install_servers_from_npm
install_scala_metals
popd
