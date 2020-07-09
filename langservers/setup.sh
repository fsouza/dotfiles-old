#!/usr/bin/env bash

set -eu

ROOT=$(cd "$(dirname "${0}")" && pwd -P)

cache_dir=${1}

if [ -z "${cache_dir}" ]; then
	echo "the cache dir is required. Please provide it as a positional parameter" >&2
	exit 2
fi

function _clone_or_update {
	repo=$1
	path=$2

	if [ -d "${path}" ]; then
		git -C "${path}" pull
	else
		git clone "${repo}" "${path}"
	fi
	git -C "${path}" submodule update --init --recursive
}

function install_ocaml_lsp {
	if ! command -v opam &>/dev/null; then
		echo skipping ocaml-lsp
		return
	fi
	path="${cache_dir}/ocaml-lsp"
	_clone_or_update https://github.com/ocaml/ocaml-lsp.git "${path}" &&
		opam update -y &&
		opam install -y dune ocamlformat &&
		pushd "${path}" &&
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
	fi
	curl -sLo "${ROOT}/bin/rust-analyzer" "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-${suffix}"
	chmod +x "${ROOT}/bin/rust-analyzer"
}

function install_servers_from_npm {
	npm ci
}

function install_ms_python_ls {
	if ! command -v dotnet; then
		echo skipping microsoft python-language-server
		return
	fi
	path="${cache_dir}/python-language-server"
	_clone_or_update https://github.com/microsoft/python-language-server.git "${path}" &&
		pushd "${path}/src/LanguageServer/Impl" &&
		dotnet build &&
		popd
}

function install_efm_ls {
	if ! command -v go &>/dev/null; then
		echo skipping efm
		return
	fi
	(
		# shellcheck disable=SC2030,SC2031
		export GO111MODULE=on GOBIN="${ROOT}/bin"
		dir=$(mktemp -d)
		git clone -b fix-panic-in-handler --depth 1 https://github.com/fsouza/efm-langserver.git "${dir}" &&
			cd "${dir}" &&
			go install &&
			cd - &&
			rm -rf "${dir}"
	)
}

function install_gopls {
	if ! command -v go &>/dev/null; then
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

function install_lua_lsp {
	if ! command -v ninja &>/dev/null; then
		echo skipping lua-lsp
		return
	fi
	if [[ $OSTYPE == darwin* ]]; then
		ninja_file=ninja/macos.ninja
	elif [[ $OSTYPE == linux* ]]; then
		ninja_file=ninja/linux.ninja
	else
		echo "install_lua_lsp: unuspported OSTYPE=${OSTYPE}"
		return
	fi
	path=${cache_dir}/lua-language-server
	_clone_or_update https://github.com/sumneko/lua-language-server "${path}" &&
		pushd "${path}" &&
		cd 3rd/luamake &&
		ninja -f "${ninja_file}" &&
		cd ../.. &&
		./3rd/luamake/luamake rebuild &&
		popd
}

pushd "$ROOT"
git submodule update --init --recursive
mkdir -p "${cache_dir}"
install_servers_from_npm &
install_ocaml_lsp &
install_rust_analyzer &
install_ms_python_ls &
install_efm_ls &
install_gopls &
install_lua_lsp &
wait
popd
