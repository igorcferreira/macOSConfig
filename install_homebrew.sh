#!/usr/bin/env bash
# fail if any commands fails
#We are skipping the homebrew errors to support beta OS'
set -e

#Install Homebrew
if which brew > /dev/null; then 
	echo "Homebrew already installed"
else
	echo "Installing Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

set +e
brew bundle || true
set -e

echo "Installed Homebrew"
