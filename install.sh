#!/bin/sh
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Starting dotfiles installation..."

# Create necessary directories
mkdir -p "$HOME/.config"

# Create symlinks
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Copy iTerm2 preferences (macOS only)
if [ "$(uname)" = 'Darwin' ]; then
    echo "Copying iTerm2 preferences..."
    if [ -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" ]; then
        cp -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"
    else
        echo "Warning: iTerm2 preference file not found"
    fi

    echo "Creating Brewfile symlink..."
    ln -sf "$DOTFILES_DIR/Brewfile" "$HOME/Brewfile"
else
    echo "Error: Your platform ($(uname -a)) is not supported."
    exit 1
fi

# Make scripts executable
chmod +x "$DOTFILES_DIR/install.sh"
chmod +x "$DOTFILES_DIR/install-mac.sh"

# Run macOS-specific installation
if [ "$(uname)" = 'Darwin' ]; then
    echo "Running macOS-specific installation..."
    "$DOTFILES_DIR/install-mac.sh"

    echo "Installing packages from Brewfile..."
    brew bundle --global
fi

echo "Installation completed successfully!"
