#!/usr/bin/env bash

set -e

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

	pushd "$ROOT/langservers/ocaml-lsp" &&
		git submodule update --init --recursive &&
		opam install --deps-only . &&
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

function install_rust_analyzer {
	if ! command -v cargo &>/dev/null; then
		echo skipping rust-analyzer
		return
	fi
	pushd "$ROOT/langservers/rust-analyzer" &&
		cargo build &&
		popd
}

function install_servers_from_npm {
	pushd "$ROOT/langservers" &&
		npm ci &&
		popd
}

pushd $ROOT
init
install_dune
install_yaml_server
install_ocaml_lsp
install_reason_lsp
install_rust_analyzer
install_servers_from_npm
popd
