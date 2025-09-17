#!/bin/sh

echo "Installing dotfiles..."

# TODO: allow calling script from any directory
# currently must be called from the directory where it is located
# due to use of relative paths
ln -s $(realpath ./alacritty) $HOME/.config
ln -s $(realpath ./nvim) $HOME/.config
ln -s $(realpath ./.tmux.conf) $HOME

export STARSHIP_CONFIG=./starship.toml

if command -v zsh &> /dev/null
then
    zsh ./zsh/install.zsh
fi
