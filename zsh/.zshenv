# how did it get to be here?
if [[ -f "$HOME/cargo/env"]]; then
    . "$HOME/.cargo/env"
fi

export XDG_CONFIG_HOME=$HOME/dotfiles
export ZDOTDIR=$HOME/dotfiles/zsh
