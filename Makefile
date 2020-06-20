mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: pip
pip:
	pip install --upgrade pip pynvim pip-tools

.PHONY: setup-langservers
setup-langservers:
	cd $(mkfile_dir) && ./langservers/setup.sh

.PHONY: plug-setup
plug-setup: install-vim-plug
	env NVIM_BOOTSTRAP=1 nvim --headless +'PlugInstall|qa' +cq

.PHONY: install-vim-plug
install-vim-plug:
	mkdir -p $(mkfile_dir)autoload
	curl -sLo $(mkfile_dir)autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/HEAD/plug.vim

.PHONY: bootstrap
bootstrap: pip setup-langservers plug-setup

.PHONY: shellcheck
shellcheck:
	shellcheck lsp-bin/*-lsp langservers/setup.sh
