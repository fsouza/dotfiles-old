mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

LUACHECK := $(if $(shell command -v luacheck 2>/dev/null), luacheck, $(shell nvim --headless -E -u NORC -R +'echo stdpath("cache")' +q 2>&1)/hr/bin/luacheck)

LUAFORMAT := $(if $(shell command -v lua-format 2>/dev/null), lua-format, $(shell nvim --headless -E -u NORC -R +'echo stdpath("cache")' +q 2>&1)/hr/bin/lua-format)

MACOSX_DEPLOYMENT_TARGET ?= 10.15

.PHONY: bootstrap
bootstrap:
	cd $(mkfile_dir) && env MACOSX_DEPLOYMENT_TARGET=$(MACOSX_DEPLOYMENT_TARGET) NVIM_BOOTSTRAP=1 nvim --headless -E -u NORC +'set rtp+=$(mkfile_dir)' +'luafile scripts/bootstrap.lua' +qa

.PHONY: shellcheck
shellcheck:
	shellcheck langservers/bin/*-lsp langservers/setup.sh

.PHONY: luacheck
luacheck:
	cd $(mkfile_dir) && $(LUACHECK) lua

.PHONY: lua-format
lua-format:
	cd $(mkfile_dir) && git ls-files | grep '\.lua$$' | xargs $(LUAFORMAT) -i
