#!/bin/zsh
# fail if any commands fails
set -e

SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/master"

if which rbenv > /dev/null; then
	echo "Rbenv already installed"
else 
	if which brew > /dev/null; then
		echo "Installing Rbenv"
		brew install rbenv
		BREW_PREFIX="$(brew --prefix)"
		eval "$($BREW_PREFIX/bin/rbenv init - zsh)"
	else
		echo "Rbenv cannot be configured"
		echo 1
	fi
fi

LATEST_VERSION="$(rbenv install -l | grep -v - | tail -1)"
echo "Installing and configuring Ruby ${LATEST_VERSION}"
rbenv install -s "${LATEST_VERSION}"
rbenv global "${LATEST_VERSION}"

LOCAL_GEM_FILE="$(pwd)/Gemlist"
if [ -f "${LOCAL_GEM_FILE}" ]; then
	echo "Getting Gemlist locally"
	gem install --conservative $(cat "${LOCAL_GEM_FILE}")
else
	echo "Reading Gemlist from repository"
	gem install --conservative $(curl -fsSL "${SCRIPT_REPO}/Gemlist")
fi

gem cleanup