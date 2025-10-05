#!/bin/sh


DOTFILES_DIR=$(dirname $(realpath $0))

echo "Installing ${DOTFILES_DIR}"

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME=$DOTFILES_DIR
else
  echo "XDG_CONFIG_HOME is set to '$XDG_CONFIG_HOME'"
  echo "but this script requires it to be set to '$DOTFILES_DIR'"
  echo "Please unset XDG_CONFIG_HOME and try again."
  return 1
fi



# TODO: allow calling script from any directory
# currently must be called from the directory where it is located
# due to use of relative paths
# ln -s $(realpath ./alacritty) $HOME/.config
# ln -s $(realpath ./nvim) $HOME/.config
# ln -s $(realpath ./.tmux.conf) $HOME

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

alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/.tmux.conf'
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml


if command -v zsh &> /dev/null
then
    zsh ${DOTFILES_DIR}/zsh/install.zsh ${DOTFILES_DIR}/zsh
fi
