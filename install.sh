#!/bin/sh

echo "Installing dotfiles..."

# TODO: allow calling script from any directory
# currently must be called from the directory where it is located
# due to use of relative paths
ln -s $(realpath ./alacritty) $HOME/.config
ln -s $(realpath ./nvim) $HOME/.config
ln -s $(realpath ./.tmux.conf) $HOME

set -x
env

if command -v starship &> /dev/null
then
    echo "Starship is already installed"
else
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh > /tmp/install_starship.sh
    chmod +x /tmp/install_starship.sh
    mkdir -p $HOME/.local/bin
    /tmp/install_starship.sh -y -b $HOME/.local/bin
    rm /tmp/install_starship.sh
fi
export STARSHIP_CONFIG=./starship.toml

if command -v zsh &> /dev/null
then
    zsh ./zsh/install.zsh
fi
