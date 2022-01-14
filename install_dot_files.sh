#!/bin/zsh
# fail if any commands fails
set -e

# shellcheck disable=SC2164
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

ln -s "${SCRIPT_PATH}/dotfiles/.bash_functions" "${HOME}/.bash_functions"
ln -s "${SCRIPT_PATH}/dotfiles/.zprofile" "${HOME}/.zprofile"
ln -s "${SCRIPT_PATH}/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -s "${SCRIPT_PATH}/dotfiles/.gitconfig" "${HOME}/.gitconfig"