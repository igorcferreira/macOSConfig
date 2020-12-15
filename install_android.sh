#!/usr/bin/env bash
# fail if any commands fails
set -e

ANDROID_HOME="$HOME/Library/Android/sdk"
ANDROID_TOOL_VERSION="sdk-tools-darwin-4333796"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

function install_component {
	COMPONENT="$1"
	SPECIFIC_COMPONENT="$($ANDROID_HOME/tools/bin/sdkmanager --list --sdk_root=$ANDROID_HOME | tac | grep -m1 "$COMPONENT" | awk '{print $1}')"
	$ANDROID_HOME/tools/bin/sdkmanager --install --sdk_root=$ANDROID_HOME "$SPECIFIC_COMPONENT"
}

if [ -d "$ANDROID_HOME" ]; then
	echo "Android sdk already installed"
else
	mkdir -p "$ANDROID_HOME"
	wget "https://dl.google.com/android/repository/$ANDROID_TOOL_VERSION.zip" -O sdk.zip && unzip sdk.zip -d $ANDROID_HOME && rm sdk.zip
fi

if [ -f "$HOME/.android/repositories.cfg" ]; then
	echo "Config file already in place"
else
	if [[ -f "$HOME/.android/repositories.cfg" ]]; then
		if [[ ! -d "$HOME/.android" ]]; then
			mkdir "$HOME/.android"
		fi
		touch "$HOME/.android/repositories.cfg"
	fi
fi

yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
$ANDROID_HOME/tools/bin/sdkmanager --update

install_component "platform-tools"
install_component "build-tools"
install_component "emulator"
install_component "platforms;"
install_component "sources;"
install_component "ndk;"
install_component "cmake;"
install_component "ndk-bundle"
install_component "lldb;"
install_component "extras;.*constraint-layout;"
install_component "extras;.*constraint-layout-solver;"
install_component "extras;intel;Hardware_Accelerated_Execution_Manager"


yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses


echo "Installed Android"