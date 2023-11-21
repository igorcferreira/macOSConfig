#!/bin/zsh
# fail if any commands fails
set -e

SCRIPT_REPO="https://raw.githubusercontent.com/igorcferreira/macOSConfig/main"

if which rvm > /dev/null; then
	echo "RVM already installed"
else
	if which gpg > /dev/null; then
		gpg --keyserver hkps://keys.openpgp.org --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	fi
	curl -sSL https://get.rvm.io | bash -s stable --rails --ignore-dotfiles
fi

LOCAL_GEM_FILE="$(pwd)/Gemlist"
if [ -f "${LOCAL_GEM_FILE}" ]; then
	echo "Getting Gemlist locally"
	gem install --conservative $(cat "${LOCAL_GEM_FILE}")
else
	echo "Reading Gemlist from repository"
	gem install --conservative $(curl -fsSL "${SCRIPT_REPO}/Gemlist")
fi

gem cleanup