#!/bin/bash -el

brew info --installed --json | \
	 jq -r '.[] | if .installed[].installed_on_request then . else empty end | (.name + " " + (.installed[].used_options | join (" ")) + " " + (if (.installed[].version | test("^HEAD-")) then "--HEAD" else "" end) + " " + (if (.installed[].poured_from_bottle | not) then "-s" else "" end)) | rtrimstr(" ")' \
	 > "$1"

brew tap > "${1}-tap"
if [[ ${OS_NAME} == "Darwin" ]]; then
	brew cask list > "${1}-cask"
fi
