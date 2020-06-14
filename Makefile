mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: pip
pip:
	pip install --upgrade pip pynvim pip-tools

.PHONY: setup-langservers
setup-langservers:
	cd $(mkfile_dir) && ./langservers/setup.sh

.PHONY: update-spell
update-spell:
	cd $(mkfile_dir)/spell && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl

.PHONY: plug-setup
plug-setup:
	if command -v nvim &>/dev/null; then nvim --headless +'PlugInstall|qa' +cq; fi

.PHONY: bootstrap
bootstrap: submodules pip setup-langservers plug-setup

.PHONY: submodules
submodules:
	git -C "$(mkfile_dir)" submodule update --init --recursive

.PHONY: clean
clean:
	git clean -dfx

.PHONY: rebootstrap
rebootstrap: clean bootstrap

.PHONY: shellcheck
shellcheck:
	shellcheck bin/vim-* langservers/setup.sh
