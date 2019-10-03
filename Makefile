.PHONY: pip gem setup-langservers bootstrap update-spell

mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))

REQUIREMENTS=\
	     flake8 \
	     pynvim \
	     black \
	     pyls-black \
	     pyls-isort \
	     pyls-mypy

pip:
	pip install --upgrade pip $(REQUIREMENTS)

gem:
	gem install neovim

setup-langservers:
	cd $$(dirname $(mkfile_path)) && ./setup-langservers.sh

update-spell:
	cd $$(dirname $(mkfile_path))/spell && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl && \
		curl -sLO http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl

bootstrap: pip gem setup-langservers
