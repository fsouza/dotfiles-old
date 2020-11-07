mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

LUACHECK := $(if $(shell command -v luacheck 2>/dev/null), luacheck, $(shell nvim --headless -E -u NORC -R +'echo stdpath("cache")' +q 2>&1)/hr/bin/luacheck)

.PHONY: bootstrap
bootstrap:
	env NVIM_BOOTSTRAP=1 MACOSX_DEPLOYMENT_TARGET=10.15 nvim --headless -E -u NORC +'set rtp+=$(mkfile_dir)' +'luafile scripts/bootstrap.lua' +qa

.PHONY: shellcheck
shellcheck:
	shellcheck langservers/bin/*-lsp langservers/setup.sh

.PHONY: luacheck
luacheck:
	cd $(mkfile_dir) && $(LUACHECK) lua tests

.PHONY: test
test:
	cd $(mkfile_dir) && ./bustedw
