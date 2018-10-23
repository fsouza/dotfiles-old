#!/bin/bash -e

function install_java_server {
	if [ -n "${JDTLS_LOCATION}" ]; then
		if [ ! -d "${JDTLS_LOCATION}" ]; then
			git clone https://github.com/eclipse/eclipse.jdt.ls.git "${JDTLS_LOCATION}"
		fi
		pushd "${JDTLS_LOCATION}"
		export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_192.jdk/Contents/Home/
		./mvnw verify
		popd
	else
		echo "skipping jdt server, no JDTLS_LOCATION... "
	fi
}

function install_servers_from_npm {
	npm i -g ocaml-language-server javascript-typescript-langserver dockerfile-language-server-nodejs
}

install_java_server
install_servers_from_npm
