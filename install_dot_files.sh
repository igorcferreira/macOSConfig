#!/usr/bin/env bash
# fail if any commands fails
set -e

SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/master"
DOT_FILES_PATH="$HOME/.dot_files"

function configure_dot_file {
	FILE="$1"
	echo "Installing $FILE"
	
	if [ -f "$DOT_FILES_PATH/$FILE" ]; then
		echo "Removing dot file"
		rm "$DOT_FILES_PATH/$FILE"
	fi

	touch "$DOT_FILES_PATH/$FILE"
	curl "$SCRIPT_REPO/$FILE" -o "$DOT_FILES_PATH/$FILE"

	if [ -f "$HOME/$FILE" ]; then
		echo "Removing original dot file"
		rm "$HOME/$FILE"
	fi

	ln -s "$DOT_FILES_PATH/$FILE" "$HOME/$FILE"
}

if [ ! -d "$DOT_FILES_PATH" ]; then
	mkdir "$DOT_FILES_PATH"
fi

configure_dot_file .profile
configure_dot_file .bash_functions
configure_dot_file .bash_profile
configure_dot_file .zprofile
configure_dot_file .zshrc

source "$HOME/.zprofile"
source "$HOME/.zshrc"

echo "Installed dot files"