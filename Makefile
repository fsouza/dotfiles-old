.PHONY: pip setup-langservers bootstrap echo-path

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))

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
	cd $$(dirname $(mkfile_path)) && ./setup-langservers.bash

bootstrap: pip gem setup-langservers
