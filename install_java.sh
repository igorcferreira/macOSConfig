#!/bin/zsh
# fail if any commands fails
set -e

brew tap adoptopenjdk/openjdk
brew cask install adoptopenjdk8
brew untap adoptopenjdk/openjdk
brew cleanup
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`