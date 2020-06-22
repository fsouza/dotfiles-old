#!/usr/bin/env bash

set -eu

ROOT=$(cd "$(dirname "${0}")" && pwd -P)

function init {
	git submodule update --init --recursive
}

function install_ocaml_lsp {
	if ! command -v opam &>/dev/null; then
		echo skipping ocaml-lsp
		return
	fi
	opam update -y
	opam install -y dune

	pushd "$ROOT/ocaml-lsp" &&
		git submodule update --init --recursive &&
		opam install -y ocamlformat &&
		opam install --deps-only -y . &&
		dune build @install &&
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

	curl -sLo "${ROOT}/bin/rust-analyzer" "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-${suffix}"
	chmod +x "${ROOT}/bin/rust-analyzer"
}

function install_servers_from_npm {
	npm ci
}

function install_servers_from_pypi {
	pip install -r requirements.txt
}

function install_ms_python_ls {
	if ! command -v dotnet; then
		echo skipping microsoft python-language-server
		return
	fi

	pushd "$ROOT/python-language-server/src/LanguageServer/Impl" &&
		dotnet build &&
		popd
}

function install_efm_ls {
	if ! command -v go; then
		echo skipping efm
		return
	fi
	(
		# shellcheck disable=SC2030,SC2031
		export GO111MODULE=on GOBIN="${ROOT}/bin"
		cd /tmp &&
			go get github.com/mattn/efm-langserver@master
	)
}

function install_gopls {
	if ! command -v go; then
		echo skipping gopls
		return
	fi
	(
		# shellcheck disable=SC2030,SC2031
		export GO111MODULE=on GOBIN="${ROOT}/bin"
		cd /tmp &&
			go get golang.org/x/tools/gopls@master golang.org/x/tools@master &&
			go get golang.org/x/tools/cmd/goimports@master &&
			go get honnef.co/go/tools/cmd/staticcheck@master
	)
}

pushd "$ROOT"
init
install_servers_from_npm &
install_servers_from_pypi &
install_ocaml_lsp &
install_rust_analyzer &
install_ms_python_ls &
install_efm_ls &
install_gopls &
wait
popd
