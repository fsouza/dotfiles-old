.PHONY: pip setup-langservers bootstrap

REQUIREMENTS=\
	     flake8 \
	     pynvim \
	     black \
	     pyls-black \
	     pyls-isort \
	     pyls-mypy \
	     fortran-language-server \
	     websocket-client \
	     sexpdata

pip:
	pip install --upgrade pip $(REQUIREMENTS)

gem:
	gem install neovim

setup-langservers:
	./setup-langservers.bash

bootstrap: pip gem setup-langservers
