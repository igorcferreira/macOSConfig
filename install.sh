#!/usr/bin/env bash
# fail if any commands fails
set -e

SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/master"

function execute_remote_script {
	echo "Executing $1"
	sh -c "$(curl -fsSL $SCRIPT_REPO/$1.sh)"
}

set +e
#Errors in the install of command line 
#are being ignored for the case where
#the command line tool is already installed
sudo xcode-select --install || true
set -e

execute_remote_script install_homebrew
execute_remote_script install_oh_my_zsh
execute_remote_script install_rvm
execute_remote_script install_java
execute_remote_script install_android

execute_remote_script install_applications

echo "Done! Now, don't forget to import your .ssh export, necessary .p12, and GPG keys!"