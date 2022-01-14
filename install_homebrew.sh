#!/bin/zsh
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
BREWFILE="$TMPDIR/Brewfile"

if [ -f "$BREWFILE" ]; then
	echo "Removing temp Brewfile"
	rm "$BREWFILE"
fi

curl "https://raw.githubusercontent.com/igorcferreira/macOSConfig/master/Brewfile" > "$BREWFILE"
brew bundle --file=$BREWFILE || true
set -e
rm "$BREWFILE"

echo "Installed Homebrew"
