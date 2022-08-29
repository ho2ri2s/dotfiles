#!/bin/sh
ln -sf ~/dotfiles/.profile ~/.profile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

ln -sf ~/dotfiles/.config/starship.toml

if [ "$(uname)" == 'Darwin' ]; then
    ln -sf ~/dotfiles/.Brewfile ~/.Brewfile
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

chmod +x ~/dotfiles/install.sh
chmod +x ~/dotfiles/install-mac.sh

./install-mac.sh
