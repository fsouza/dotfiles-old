.PHONY: pip

REQUIREMENTS=\
	     neovim \
	     flask \
	     django \
	     tornado \
	     boto3

pip:
	pip install --upgrade $(REQUIREMENTS)
