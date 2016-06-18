.PHONY: pip

REQUIREMENTS=\
	     neovim \
	     flask \
	     django \
	     tornado \
	     flake8 \
	     autopep8 \
	     boto3

pip:
	pip install --upgrade $(REQUIREMENTS)
