#!/bin/bash -l

function backup_line() {
	formula_name="$1"
	from_source=$(brew info $formula_name | grep "Built from source on.\+with: .\+")
	from_head=$(brew info $formula_name | grep -B1 "Built from source on" | grep /HEAD-)

	flags=""
	if [ -n "${from_source}" ]; then
		flags=$(echo $from_source | sed -e "s/^Built from source on .* with: //")
	fi

	if [ -n "${from_head}" ]; then
		flags="--HEAD $flags"
	fi

	if [ -n "${flags}" ]; then
		formula_name="$formula_name $flags"
	fi

	echo $formula_name
}

>"$1"
for formula in $(brew leaves); do
	backup_line "${formula}" >> "$1"
done

brew tap > "${1}-tap"
if [[ ${OS_NAME} == "Darwin" ]]; then
	brew cask list > "${1}-cask"
fi
