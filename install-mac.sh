#!/bin/sh

# Homebrew
xcode-select --install
if !(type "brew" > /dev/null 2>&1); then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew bundle --global
