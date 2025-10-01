HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY


zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

#
# setup aliases
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias fd='fdfind'


#### ENVIRONMENT VARIABLES
#
# add homebrew to path if running on mac with homebrew installed
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# load machine specific environment variables
if [[ -f ~/machine/env ]]; then
  source ~/machine/env
fi

# enable starship prompt
eval "$(starship init zsh)"
