mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: shellcheck
shellcheck:
	cd $(mkfile_dir) && shellcheck bin/* nvim/langservers/bin/* nvim/langservers/setup.sh
