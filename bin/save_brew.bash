#!/bin/bash -l

function backup_line() {
	formula_name="$1"
	from_source=$(brew info $formula_name | grep "Built from source on.\+with: .\+")
	if [ -n "${from_source}" ]; then
		flags=$(echo $from_source | sed -e "s/^Built from source on .* with: //")
		formula_name="$formula_name $flags"
	fi
	echo $formula_name
}

>"$1"
for formula in $(brew leaves); do
	backup_line "${formula}" >> "$1"
done

brew cask list > "${1}-cask"
