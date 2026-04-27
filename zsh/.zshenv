# how did it get to be here?
# . "$HOME/.cargo/env"
#

if [[ -z "${ZDOTDIR}" ]]; then
	echo "PANIC! ZDOTDIR not set!"
	return -1
fi

export DOTFILES_DIR=${ZDOTDIR}/..
export XDG_CONFIG_HOME=${DOTFILES_DIR}
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml

alias tmux='tmux -f ${XDG_CONFIG_HOME}/tmux/.tmux.conf'
