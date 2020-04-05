#!/usr/bin/env bash

set -eu

ROOT=$(cd "$(dirname "${0}")" && pwd -P)

function init {
	git submodule update --init --recursive
}

function install_yaml_server {
	pushd "$ROOT/yaml-language-server"
	npm ci
	npm run compile
	popd
}

function install_dune {
	if ! command -v opam &>/dev/null; then
		echo skipping opam
		return
	fi
	opam update -y
	opam install -y dune
}

function install_ocaml_lsp {
	if ! command -v dune &>/dev/null; then
		echo skipping ocaml-lsp
		return
	fi

	pushd "$ROOT/ocaml-lsp" &&
		git submodule update --init --recursive &&
		opam install --deps-only -y . &&
		dune build @install &&
		popd
}

function install_reason_lsp {
	if ! command -v dune &>/dev/null; then
		echo skipping reason-language-server
		return
	fi
	pushd "$ROOT/reason-language-server" &&
		../node_modules/.bin/esy &&
		popd
}

function install_rust_analyzer {
	local suffix

	if ! command -v cargo &>/dev/null; then
		echo skipping rust-analyzer
		return
	fi

	if [[ $OSTYPE == darwin* ]]; then
		suffix=mac
	elif [[ $OSTYPE == linux* ]]; then
		suffix=linux
	else
		echo "install-rust-analyzer: unuspported OSTYPE=${OSTYPE}"
		return
	fi

	curl -sLo ../bin/rust-analyzer "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-${suffix}"
	chmod +x ../bin/rust-analyzer
}

function install_servers_from_npm {
	npm ci
}

function install_servers_from_pypi {
	pip install -r requirements.txt
}

pushd "$ROOT"
init
install_dune
install_servers_from_npm
install_servers_from_pypi
install_yaml_server
install_ocaml_lsp
install_reason_lsp
install_rust_analyzer
popd
