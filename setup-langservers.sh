#!/bin/zsh

ROOT=$(cd `dirname ${0}` && pwd -P)

function init {
	git submodule update --init --recursive
}

function install_yaml_server {
	pushd "$ROOT/langservers/yaml-language-server"
	npm ci
	npm run compile
	popd
}

function install_fsharp_server {
	if ! command -v dotnet &>/dev/null; then
		echo skipping fsharp-language-server
		return
	fi
	pushd "$ROOT/langservers/fsharp-language-server"
	npm ci
	dotnet build -c Release
	popd
}

function install_merlin_lsp {
	if ! command -v opam &>/dev/null; then
		echo skipping merlin-lsp
		return
	fi
	opam pin merlin-lsp.dev https://github.com/ocaml/merlin.git -y
}

function install_servers_from_npm {
	npm i --no-save \
		bash-language-server \
		dockerfile-language-server-nodejs \
		vscode-css-languageserver-bin \
		vscode-html-languageserver-bin \
		vscode-json-languageserver-bin \
		vim-language-server
}

pushd $ROOT
init
install_yaml_server
install_fsharp_server
install_merlin_lsp
install_servers_from_npm
popd
