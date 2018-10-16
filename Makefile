.PHONY: pip setup-langservers bootstrap

REQUIREMENTS=\
	     flake8 \
	     neovim \
	     black \
	     pyls-black \
	     pyls-isort \
	     pyls-mypy \
	     fortran-language-server

pip:
	pip install --upgrade $(REQUIREMENTS)

setup-langservers:
	./setup-langservers.bash

bootstrap: pip setup-langservers
