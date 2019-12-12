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

function install_ocaml_lsp {
	if ! command -v dune &>/dev/null; then
		echo skipping ocaml-lsp
		return
	fi
	pushd "$ROOT/langservers/ocaml-lsp" &&
		git submodule update --init --recursive &&
		dune build @install &&
		popd
}

function install_reason_lsp {
	if ! command -v dune &>/dev/null; then
		echo skipping reason-language-server
		return
	fi
	npm i --no-save esy &&
		pushd "$ROOT/langservers/reason-language-server" &&
		../../node_modules/.bin/esy &&
		popd
}

function install_nim_lsp {
	if ! command -v nimble &>/dev/null; then
		echo skipping nimlsp
		return
	fi

	pushd "$ROOT/langservers/nimlsp" &&
		git submodule update --init --recursive &&
		nimble build -y &&
		popd
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
install_ocaml_lsp
install_reason_lsp
install_nim_lsp
install_servers_from_npm
popd
