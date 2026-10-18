#!/bin/zsh
# fail if any commands fails
set -e

export ANDROID_HOME="${HOME}/Library/Android/sdk"

mkdir -p "${HOME}/.android"
touch "${HOME}/.android/repositories.cfg"

if ! command -v android >/dev/null; then
	echo "Installing Android CLI"
	[[ "$(uname -m)" == "arm64" ]] && ARCH="arm64" || ARCH="x86_64"
	curl -fsSL "https://dl.google.com/android/cli/latest/darwin_${ARCH}/install.sh" | bash
	export PATH="${HOME}/.local/bin:${PATH}"
fi

android --sdk="${ANDROID_HOME}" sdk install "cmdline-tools/latest" "emulator" "platform-tools" "extras/google/google_play_services"
android --sdk="${ANDROID_HOME}" sdk update

echo "Installed Android on ${ANDROID_HOME}"
