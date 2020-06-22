mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: pip
pip:
	pip install --upgrade pip pynvim pip-tools

.PHONY: setup-langservers
setup-langservers:
	cd $(mkfile_dir) && ./langservers/setup.sh

.PHONY: bootstrap
bootstrap: pip setup-langservers

.PHONY: shellcheck
shellcheck:
	shellcheck langservers/bin/*-lsp langservers/setup.sh
