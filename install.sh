#!/bin/zsh
# fail if any commands fails
set -e

RELEASE_VERSION="1.0.0"
SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/${RELEASE_VERSION}"

function execute_script {
	COMMAND_NAME="$1.sh"
	LOCAL_FILE="$(pwd)/${COMMAND_NAME}"

	if [ -f "${LOCAL_FILE}" ]; then
		echo "Executing ${LOCAL_FILE}"
		chmod +x "${LOCAL_FILE}"
		"${LOCAL_FILE}"
	else
		echo "Executing ${COMMAND_NAME}"
		sh -c "$(curl -fsSL "${SCRIPT_REPO}/${COMMAND_NAME}")"
	fi
}

while [ -n "$1" ]; do
    case "$1" in
        --version | -v) echo "${RELEASE_VERSION}" && exit 0;;
    esac
    shift
done

set +e
#Errors in the install of command line 
#are being ignored for the case where
#the command line tool is already installed
sudo xcode-select --install || true
set -e

execute_script install_homebrew
execute_script configure_ruby
execute_script install_java
execute_script install_android
execute_script install_oh_my_zsh

echo "Done! Now, don't forget to import your .ssh export, necessary .p12, and GPG keys!"
