#!/bin/sh

# Install Xcode Command Line Tools
xcode-select --install 2>/dev/null || echo "Xcode tools already installed"

# Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
