#!/bin/zsh
# fail if any commands fails
set -e

ANDROID_HOME="$HOME/Library/Android/sdk"
ANDROID_TOOL_VERSION="commandlinetools-mac-7583922_latest"

if which brew > /dev/null; then
	brew tap adoptopenjdk/openjdk
	brew install --cask adoptopenjdk8
	brew cleanup
fi

if [ -d "$ANDROID_HOME" ]; then
	echo "Android sdk already installed"
else
	mkdir -p "$ANDROID_HOME"
	curl -L -X GET "https://dl.google.com/android/repository/${ANDROID_TOOL_VERSION}.zip" -o sdk.zip && unzip sdk.zip -d "${ANDROID_HOME}" && rm sdk.zip
	JAVA_HOME="$(/usr/libexec/java_home -v 1.8)" yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
fi

if [ -f "$HOME/.android/repositories.cfg" ]; then
	echo "Config file already in place"
else
	echo "Writting repositories.cfg"
	if [[ ! -d "$HOME/.android" ]]; then
		mkdir "$HOME/.android"
	fi
	touch "$HOME/.android/repositories.cfg"
fi

JAVA_HOME="$(/usr/libexec/java_home -v 1.8)" yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
JAVA_HOME="$(/usr/libexec/java_home -v 1.8)" $ANDROID_HOME/tools/bin/sdkmanager --update

echo "Installed Android"