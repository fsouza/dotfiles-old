#!/usr/bin/env bash

set -eu

cache_dir=${1}
exit_status=0

function process_child() {
	if [[ ${1} -gt 0 ]]; then
		exit_status=${1}
	fi
}

trap 'process_child $?' CHLD

if [ -z "${cache_dir}" ]; then
	echo "the cache dir is required. Please provide it as a positional parameter" >&2
	exit 2
fi

function _clone_or_update() {
	repo=$1
	path=$2

	if [ -d "${path}" ]; then
		git -C "${path}" pull
	else
		git clone "${repo}" "${path}"
	fi
	git -C "${path}" submodule update --init --recursive
}

function install_ocaml_lsp() {
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

function install_rust_analyzer() {
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
	mkdir -p "${cache_dir}/bin"
	curl -sLo "${cache_dir}/bin/rust-analyzer" "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-${suffix}"
	chmod +x "${cache_dir}/bin/rust-analyzer"
}

function install_servers_from_npm() {
	npm ci
}

function install_fsharp_language_server() {
	if ! command -v dotnet; then
		echo skipping fsharp-language-server
		return
	fi
	path="${cache_dir}/fsharp-language-server"
	_clone_or_update https://github.com/fsprojects/fsharp-language-server.git "${path}" &&
		pushd "${path}" &&
		npm ci &&
		dotnet build -c Release &&
		popd
}

function _go_get() {
	if ! command -v go &>/dev/null; then
		echo skipping
		return
	fi
	(
		# shellcheck disable=SC2068
		cd /tmp && env GO111MODULE=on GOBIN="${cache_dir}/bin" go get ${@}
	)
}

function install_gopls() {
	_go_get "golang.org/x/tools/gopls@master golang.org/x/tools@master" &&
		_go_get golang.org/x/tools/cmd/goimports@master &&
		_go_get honnef.co/go/tools/cmd/staticcheck@master
}

function install_shfmt() {
	_go_get mvdan.cc/sh/v3/cmd/shfmt@master
}

function install_golangci_lint_langserver() {
	_go_get github.com/nametake/golangci-lint-langserver@master &&
		_go_get github.com/golangci/golangci-lint/cmd/golangci-lint@latest
}

function install_lua_lsp() {
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

pushd "$(dirname "${0}")"
git submodule update --init --recursive
mkdir -p "${cache_dir}"
install_servers_from_npm &
install_ocaml_lsp &
install_rust_analyzer &
install_fsharp_language_server &
install_gopls &
install_lua_lsp &
install_shfmt &
install_golangci_lint_langserver &
wait
popd

exit "${exit_status}"
