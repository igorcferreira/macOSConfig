#!/bin/zsh
# fail if any commands fails
set -e

ANDROID_HOME="${HOME}/Library/Android/sdk"

if [ -f "${HOME}/.android/repositories.cfg" ]; then
	echo "Config file already in place"
else
	echo "Writting repositories.cfg"
	if [[ ! -d "${HOME}/.android" ]]; then
		mkdir "${HOME}/.android"
	fi
	touch "${HOME}/.android/repositories.cfg"
fi

if [ -d "${ANDROID_HOME}" ]; then
	echo "Android sdk already installed"
else
	ANDROID_TOOL_VERSION="commandlinetools-mac-13114758_latest"
	mkdir -p "${ANDROID_HOME}"
	
	TEMP_DIR="$(pwd)/.tmp"
	if [ -d "${TEMP_DIR}" ]; then
		rm -rf "${TEMP_DIR}"
	fi
	
	curl -L -X GET "https://dl.google.com/android/repository/${ANDROID_TOOL_VERSION}.zip" -o sdk.zip && unzip sdk.zip -d "${TEMP_DIR}" && rm sdk.zip
	JAVA_HOME="$(/usr/libexec/java_home)" yes | $TEMP_DIR/cmdline-tools/bin/sdkmanager --licenses --sdk_root="${ANDROID_HOME}"
	JAVA_HOME="$(/usr/libexec/java_home)" $TEMP_DIR/cmdline-tools/bin/sdkmanager --install "cmdline-tools;latest" --sdk_root="${ANDROID_HOME}"
	
	rm -rf "$TEMP_DIR"

	JAVA_HOME="$(/usr/libexec/java_home)" $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --install "emulator" "platform-tools" "extras;google;google_play_services"
fi

JAVA_HOME="$(/usr/libexec/java_home)" $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --update

echo "Installed Android on ${ANDROID_HOME}"