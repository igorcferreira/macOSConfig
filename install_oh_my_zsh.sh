#!/usr/bin/env bash
# fail if any commands fails
set -e

if [[ -s "$HOME/.oh-my-zsh" ]]; then
	echo "Oh My ZSH already installed"
else
	echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
