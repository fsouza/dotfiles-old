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
plug-setup: install-vim-plug
	if command -v nvim &>/dev/null; then env NVIM_BOOTSTRAP=1 nvim --headless +'PlugInstall|qa' +cq; fi

.PHONY: install-vim-plug
install-vim-plug:
	mkdir -p $(mkfile_dir)autoload
	curl -sLo $(mkfile_dir)autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/HEAD/plug.vim

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
	shellcheck lsp-bin/*-lsp langservers/setup.sh
