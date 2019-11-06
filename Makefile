mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))

REQUIREMENTS=\
	     flake8 \
	     pynvim \
	     black \
	     python-language-server[all] \
	     pyls-black \
	     pyls-mypy

.PHONY: pip
pip:
	pip install --upgrade pip $(REQUIREMENTS)

.PHONY: gem
gem:
	gem install neovim

.PHONY: setup-langservers
setup-langservers:
	cd $$(dirname $(mkfile_path)) && ./setup-langservers.sh

.PHONY: update-spell
update-spell:
	cd $$(dirname $(mkfile_path))/spell && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl

.PHONY: bootstrap
bootstrap: pip gem setup-langservers

.PHONY: clean
clean:
	git clean -dfx

.PHONY: rebootstrap
rebootstrap: clean bootstrap
