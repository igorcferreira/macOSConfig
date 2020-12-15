#!/bin/bash

set -e

function print_help() {
    echo "Usage:"
    echo "$0 --global --gpg_key AF08731 --name \"User name\" --email \"user@email.com\""
    echo ""
    echo "Variables:"
    echo "--name    -n : Name that will be set as user.name (optional)"
    echo "--email   -e : Email that will be set as user.email (optional)"
    echo "--gpg_key -gk: GPG key used to configure commit default signature (optional)"
    echo "--global     : Adds the configuration to the global configuration of git"
    echo "--local      : Adds the configuration to the local configuration of git"
    echo ""
    echo "If neither --local or --global is passed, the script uses --global as default"
}

GPG_KEY=""
CONFIGURATION=""
USER_NAME=""
USER_EMAIL=""

while [ -n "$1" ]; do
    case "$1" in
        --global | --local) CONFIGURATION="$1";;
        --gpg_key | -gk) GPG_KEY="$2" && shift;;
		--name | -n) USER_NAME="$2" && shift;;
		--email | -e) USER_EMAIL="$2" && shift;;
		--help | -h) print_help && exit 0;;
    esac
    shift
done

if [ -z "$CONFIGURATION" ]; then
	CONFIGURATION="--global"
fi

if [ -n "$USER_NAME" ]; then
	echo "Setting user name $USER_NAME"
	git config $CONFIGURATION user.name "$USER_NAME"
fi

if [ -n "$USER_EMAIL" ]; then
	echo "Setting email $USER_EMAIL"
	git config $CONFIGURATION user.email "$USER_EMAIL"
fi

echo "Adding adog alias"
git config $CONFIGURATION alias.adog "log --all --decorate --oneline --graph"

if [ -n "$GPG_KEY" ]; then

	GPG_PROGRAM="$(which gpg)"

	if [ -z "$GPG_PROGRAM" ]; then
		echo "To enable GPG signature, please, make sure that GPG suite is properly installed on your machine"
		exit 1;
	fi

	echo "Setting GPG Key: $GPG_KEY"
	git config $CONFIGURATION user.signingkey "$GPG_KEY"

	echo "Setting gpg2 as program"
	git config $CONFIGURATION gpg.program "$GPG_PROGRAM"

	echo "Enabling commit signature"
	git config $CONFIGURATION commit.gpgsign true
fi