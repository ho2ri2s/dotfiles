#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Starting dotfiles installation..."

# Create necessary directories
mkdir -p "$HOME/.config"

# ===================
# VSCode setup function
# ===================
setup_vscode() {
    local VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

    echo "Setting up VSCode..."
    mkdir -p "$VSCODE_USER_DIR"

    # Create symlinks for settings
    ln -sf "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    ln -sf "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

    # Install extensions
    if command -v code >/dev/null 2>&1; then
        echo "Installing VSCode extensions..."
        while IFS= read -r extension; do
            # Skip empty lines and comments
            case "$extension" in
                ''|\#*) continue ;;
            esac
            code --install-extension "$extension" --force
        done < "$DOTFILES_DIR/vscode/extensions.txt"
    else
        echo "Warning: VSCode CLI not found. Extensions will not be installed."
        echo "Run 'Shell Command: Install code command in PATH' from VSCode Command Palette."
    fi
}

# ===================
# Android Studio setup function
# ===================
setup_android_studio() {
    local BASE_DIR="$HOME/Library/Application Support/Google"

    echo "Setting up Android Studio..."

    # Find the latest Android Studio version directory
    local AS_DIR
    AS_DIR=$(find "$BASE_DIR" -maxdepth 1 -name "AndroidStudio*" -type d 2>/dev/null | sort -V | tail -1)

    if [ -z "$AS_DIR" ]; then
        echo "Warning: Android Studio directory not found. Skipping..."
        return 0
    fi

    echo "Found Android Studio at: $AS_DIR"

    # Copy keymap
    mkdir -p "$AS_DIR/keymaps"
    cp -f "$DOTFILES_DIR/android-studio/keymaps/custom-keymap.xml" "$AS_DIR/keymaps/"

    echo "Android Studio keymap installed."
    echo ""
    echo "Note: Plugins must be installed manually via IDE:"
    echo "  - Dart"
    echo "  - Flutter"
    echo "  - IdeaVIM"
}

# ===================
# Claude Code setup function
# ===================
setup_claude_code() {
    echo "Setting up Claude Code..."
    mkdir -p "$HOME/.claude"

    # Create symlinks for settings
    ln -sf "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
    ln -sf "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
}

# ===================
# Node.js/npm setup function
# ===================
setup_node() {
    echo "Setting up Node.js/npm..."

    # Create symlink for .npmrc
    if [ -f "$DOTFILES_DIR/node/.npmrc" ]; then
        ln -sf "$DOTFILES_DIR/node/.npmrc" "$HOME/.npmrc"
    fi

    # Check if nvm is available
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        # Load nvm
        . "$NVM_DIR/nvm.sh"

        # Install LTS version
        echo "Installing Node.js LTS..."
        nvm install --lts
        nvm use --lts

        # Install global packages
        if [ -f "$DOTFILES_DIR/node/global-packages.txt" ]; then
            echo "Installing global npm packages..."
            while IFS= read -r package; do
                # Skip empty lines and comments
                case "$package" in
                    ''|\#*) continue ;;
                esac
                npm install -g "$package"
            done < "$DOTFILES_DIR/node/global-packages.txt"
        fi
    else
        echo "Warning: nvm not found. Node.js setup skipped."
        echo "Install nvm first: https://github.com/nvm-sh/nvm"
    fi
}

# ===================
# Create symlinks
# ===================
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/.ideavimrc" "$HOME/.ideavimrc"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# ===================
# macOS specific setup
# ===================
if [ "$(uname)" = 'Darwin' ]; then
    # iTerm2 preferences
    echo "Copying iTerm2 preferences..."
    if [ -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" ]; then
        cp -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"
    else
        echo "Warning: iTerm2 preference file not found"
    fi

    # Brewfile symlink
    echo "Creating Brewfile symlink..."
    ln -sf "$DOTFILES_DIR/Brewfile" "$HOME/Brewfile"

    # VSCode setup
    setup_vscode

    # Android Studio setup
    setup_android_studio

    # Claude Code setup
    setup_claude_code

    # Node.js/npm setup
    setup_node
else
    echo "Error: Your platform ($(uname -a)) is not supported."
    exit 1
fi

# Make scripts executable
chmod +x "$DOTFILES_DIR/install.sh"
chmod +x "$DOTFILES_DIR/install-mac.sh"
chmod +x "$DOTFILES_DIR/export-settings.sh" 2>/dev/null || true

# Run macOS-specific installation
if [ "$(uname)" = 'Darwin' ]; then
    echo "Running macOS-specific installation..."
    "$DOTFILES_DIR/install-mac.sh"

    echo "Installing packages from Brewfile..."
    brew bundle --global
fi

echo "Installation completed successfully!"
