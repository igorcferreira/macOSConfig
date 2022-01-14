#!/bin/zsh
# fail if any commands fails
set -e

if which brew > /dev/null; then
	echo "Homebrew installed, we will continue with the installation"
else
    echo "This script requires Homebrew to run"
    exit 1
fi

brew tap adoptopenjdk/openjdk
brew install --cask adoptopenjdk
brew cleanup

if [ -z "$(echo $JAVA_HOME)" ]; then
    echo "Configuring JAVA_HOME"
    export JAVA_HOME="$(/usr/libexec/java_home)"

    PROFILE_FILE="${HOME}/.zprofile"
    if [ -f "${PROFILE_FILE}" ]; then
        echo "Configuring JAVA_HOME on ${PROFILE_FILE}"
        echo "\nexport JAVA_HOME=\"$(/usr/libexec/java_home)\"\n" >> "${HOME}/.zprofile"
    fi

    echo "JAVA_HOME set as ${JAVA_HOME}"
else
    echo "JAVA_HOME already set as ${JAVA_HOME}"
fi