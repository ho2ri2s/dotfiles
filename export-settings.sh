#!/bin/sh
# export-settings.sh - Export current settings to dotfiles
#
# Run this script to update dotfiles with your current settings.
# After running, commit the changes to git.

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Exporting current settings to dotfiles..."

# ===================
# VSCode
# ===================
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ -d "$VSCODE_USER_DIR" ]; then
    echo "Exporting VSCode settings..."

    # Export settings.json (only if it's not a symlink)
    if [ -f "$VSCODE_USER_DIR/settings.json" ] && [ ! -L "$VSCODE_USER_DIR/settings.json" ]; then
        cp "$VSCODE_USER_DIR/settings.json" "$DOTFILES_DIR/vscode/"
        echo "  - settings.json exported"
    fi

    # Export keybindings.json (only if it's not a symlink)
    if [ -f "$VSCODE_USER_DIR/keybindings.json" ] && [ ! -L "$VSCODE_USER_DIR/keybindings.json" ]; then
        cp "$VSCODE_USER_DIR/keybindings.json" "$DOTFILES_DIR/vscode/"
        echo "  - keybindings.json exported"
    fi

    # Export extensions list
    if command -v code >/dev/null 2>&1; then
        echo "# VSCode Extensions" > "$DOTFILES_DIR/vscode/extensions.txt"
        echo "# Install with: code --install-extension <extension-id>" >> "$DOTFILES_DIR/vscode/extensions.txt"
        code --list-extensions >> "$DOTFILES_DIR/vscode/extensions.txt"
        echo "  - extensions.txt exported"
    fi
fi

# ===================
# Android Studio
# ===================
AS_BASE_DIR="$HOME/Library/Application Support/Google"
AS_DIR=$(find "$AS_BASE_DIR" -maxdepth 1 -name "AndroidStudio*" -type d 2>/dev/null | sort -V | tail -1)

if [ -n "$AS_DIR" ] && [ -d "$AS_DIR/keymaps" ]; then
    echo "Exporting Android Studio keymaps..."
    mkdir -p "$DOTFILES_DIR/android-studio/keymaps"

    # Copy all keymaps
    for keymap in "$AS_DIR/keymaps"/*.xml; do
        if [ -f "$keymap" ]; then
            cp "$keymap" "$DOTFILES_DIR/android-studio/keymaps/"
            echo "  - $(basename "$keymap") exported"
        fi
    done
fi

# ===================
# npm global packages
# ===================
if command -v npm >/dev/null 2>&1; then
    echo "Exporting npm global packages..."
    echo "# Global npm packages" > "$DOTFILES_DIR/node/global-packages.txt"
    echo "# Install with: npm install -g <package>" >> "$DOTFILES_DIR/node/global-packages.txt"

    # Get global packages (excluding npm itself)
    npm list -g --depth=0 --parseable 2>/dev/null | \
        tail -n +2 | \
        xargs -I {} basename {} | \
        grep -v "^npm$" >> "$DOTFILES_DIR/node/global-packages.txt"

    echo "  - global-packages.txt exported"
fi

echo ""
echo "Export completed!"
echo ""
echo "Don't forget to commit your changes:"
echo "  cd $DOTFILES_DIR"
echo "  git add -A"
echo "  git commit -m 'Update settings'"
