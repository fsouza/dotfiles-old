.PHONY: pip setup-langservers bootstrap

REQUIREMENTS=\
	     flask \
	     django \
	     tornado \
	     flake8 \
	     autopep8 \
	     neovim \
	     requests \
	     schedule \
	     boto3 \
	     black \
	     fortran-language-server

pip:
	pip install --upgrade $(REQUIREMENTS)

setup-langservers:
	./setup-langservers.bash

bootstrap: pip setup-langservers
