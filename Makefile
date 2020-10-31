mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

LUACHECK := $(if $(shell command -v luacheck 2>/dev/null), luacheck, $(shell nvim --headless -E -u NORC -R +'echo stdpath("cache")' +q 2>&1)/hr/bin/luacheck)

.PHONY: bootstrap
bootstrap:
	env MACOSX_DEPLOYMENT_TARGET=10.15 nvim --headless -E -u NORC -R +'set rtp+=$(mkfile_dir)' +'luafile scripts/bootstrap.lua' +q
	env NVIM_BOOTSTRAP=1 nvim -R --headless +'PlugInstall --sync|qa' +cq

.PHONY: shellcheck
shellcheck:
	shellcheck langservers/bin/*-lsp langservers/setup.sh

.PHONY: luacheck
luacheck:
	$(LUACHECK) lua
