#!/usr/bin/env bash
# fail if any commands fails
set -e

function install_app_dmg {
	APP_NAME="$1"
	APP_DMG_IMAGE="$2"
	APP_VOLUME_NAME="$3"

	echo "Downloading $APP_NAME"
	curl -Ls "$APP_DMG_IMAGE" -o "$(pwd)/$APP_NAME.dmg"

	echo "Mounting $APP_VOLUME_NAME"
	hdiutil mount "$(pwd)/$APP_NAME.dmg"

	echo "Copying to Applications"
	sudo cp -R "/Volumes/$APP_VOLUME_NAME/$APP_NAME.app" /Applications

	echo "Unmounting $APP_VOLUME_NAME"
	hdiutil unmount "/Volumes/$APP_VOLUME_NAME"

	rm "$(pwd)/$APP_NAME.dmg"
}

function install_app_pkg {
	APP_NAME="$1"
	APP_DMG_IMAGE="$2"
	VOLUME_NAME="$3"

	curl -Ls "$APP_DMG_IMAGE" -o "$(pwd)/$APP_NAME.pkg"
	sudo installer -pkg "$(pwd)/$APP_NAME.pkg" -target "$VOLUME_NAME"
	rm "$(pwd)/$APP_NAME.pkg"
}

function install_app_zip {
	APP_NAME="$1"
	APP_ZIP="$2"

	echo "Downloading $APP_NAME"
	curl -Ls "$APP_ZIP" -o "$(pwd)/$APP_NAME.zip"

	echo "Unziping"
	unzip "$(pwd)/$APP_NAME.zip" -d "$(pwd)"

	echo "Copying file"
	cp -R "$(pwd)/$APP_NAME.app" "/Applications"

	rm -rf "$(pwd)/$APP_NAME.app"
	rm -rf "$(pwd)/$APP_NAME.zip"
}

install_app_pkg 1Password "https://c.1password.com/dist/1P/mac7/1Password-7.4.2.pkg" "/"
install_app_dmg Sublime\ Text "https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg" "Sublime Text"
