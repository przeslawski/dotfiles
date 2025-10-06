#!/bin/zsh


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

if (( $+commands[starship] )); then
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

# now let's install the new config files
ZDOTDIR=${1:-"${DOTFILES_DIR}/zsh"}
export ZDOTDIR=$ZDOTDIR


if [[ ! -d $ZDOTDIR ]]; then
mkdir -p $ZDOTDIR
echo "Created zsh config directory: $ZDOTDIR"
fi

# copy all but the install script itself
# cp zsh/^install.zsh $ZDOTDIR

echo "export ZDOTDIR=${ZDOTDIR}" >> ~/.zshenv
echo "export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}" >> ~/.zshenv
echo "export DOTFILES_DIR=${DOTFILES_DIR}" >> ~/.zshenv
echo "[[ -f ${ZDOTDIR}/.zshenv ]] && . ${ZDOTDIR}/.zshenv" >> ~/.zshenv

# if [[ -f ${BACKUP}/.zsh_history ]]; then
#   cp ${BACKUP}/.zsh_history ${ZDOTDIR}/.zsh_history
# fi

# install antidote zsh plugin manager
if [[ ! -f ${ZDOTDIR}/.antidote/antidote.zsh ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote
fi


# nvim
if (( $+commands[nvim] )); then
    # TODO: check version 0.11+
    echo "Neovim is already installed"
else
    echo "Installing Neovim..."
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    pushd /tmp/neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make CMAKE_INSTALL_PREFIX=/usr/local install
    popd
    rm -rf /tmp/neovim
fi

env

# if the shell is interactive, start zsh with new config
if [[ $- == *i* ]]
then
    zsh
fi
