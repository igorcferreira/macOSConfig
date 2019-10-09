#!/usr/bin/env bash
# fail if any commands fails
set -e

SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/master"

if which rvm > /dev/null; then
	echo "RVM already installed"
else
	echo "Installing RVM"
	command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
	\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
	source "$HOME/.rvm/scripts/rvm"
fi

gem install $(curl -fsSL "https://raw.githubusercontent.com/igorcferreira/macOSConfig/master/Gemlist")
gem cleanup