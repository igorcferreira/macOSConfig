#!/bin/zsh
# fail if any commands fails
set -e

# These variables are configured for a default M1 mac. If these need to be overwritten on your machine, create a `~/.local.env` file with the values to be overwritten
BREW_PATH="/opt/homebrew"
BREW_BIN_PATH="${BREW_PATH}/bin"

[[ -s "${HOME}/.local.env" ]] && source "${HOME}/.local.env"

ANDROID_HOME="${HOME}/Library/Android/sdk"

if which brew > /dev/null; then
	ANDROID_HOME="${BREW_PATH}/share/android-sdk"
	brew install --cask homebrew/cask-versions/temurin8
	brew install --cask android-sdk
	brew cleanup
	[[ -s "${HOME}/.zprofile" ]] && echo "\nexport ANDROID_HOME=${ANDROID_HOME}\n" >> "${HOME}/.zprofile"
else if [ -d "${ANDROID_HOME}" ]; then
	echo "Android sdk already installed"
else
	ANDROID_TOOL_VERSION="commandlinetools-mac-7583922_latest"
	mkdir -p "${ANDROID_HOME}"
	curl -L -X GET "https://dl.google.com/android/repository/${ANDROID_TOOL_VERSION}.zip" -o sdk.zip && unzip sdk.zip -d "${ANDROID_HOME}" && rm sdk.zip
fi

if [ -f "${HOME}/.android/repositories.cfg" ]; then
	echo "Config file already in place"
else
	echo "Writting repositories.cfg"
	if [[ ! -d "${HOME}/.android" ]]; then
		mkdir "${HOME}/.android"
	fi
	touch "${HOME}/.android/repositories.cfg"
fi

JAVA_HOME="$(/usr/libexec/java_home -v 1.8)" yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
JAVA_HOME="$(/usr/libexec/java_home -v 1.8)" $ANDROID_HOME/tools/bin/sdkmanager --update

echo "Installed Android"