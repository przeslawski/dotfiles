#!/bin/zsh

set -x

# Arguments:
# $1 - ZDOTDIR - directory to store zsh config files
# defaults to ~/.config/zsh
#


# first backup existing zsh config files 
# found in $ZDOTDIR or $HOME if $ZDOTDIR is not set
# and store them in ~/.bak
setopt extended_glob
setopt glob_dots

zfiles=(
  ${ZDOTDIR:-~}/.zsh*(.N)
  ${ZDOTDIR:-~}/.zlog*(.N)
  ${ZDOTDIR:-~}/.zprofile(.N)
)

local BACKUP=~/.bak

mkdir -p ${BACKUP}
for zfile in $zfiles; do
  cp $zfile ${BACKUP}
done

unset zfile zfiles

# now let's install the new config files
ZDOTDIR=${1:-"~/.config/zsh"}


mkdir -p $ZDOTDIR && echo "Created zsh config directory: $ZDOTDIR"

# copy all but the install script itself
cp zsh/^install.zsh $ZDOTDIR

cat << 'EOF' >| ~/.zshenv
export ZDOTDIR=${ZDOTDIR}
[[ -f ${ZDOTDIR}/.zshenv ]] && . ${ZDOTDIR}/.zshenv
EOF

if [[ -f ${BACKUP}/.zsh_history ]]; then
  cp ${BACKUP}/.zsh_history ${ZDOTDIR}/.zsh_history
fi

# install antidote zsh plugin manager
if [[ ! -f ${ZDOTDIR}/.antidote/antidote.zsh ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote
fi

export ZDOTDIR=$ZDOTDIR

# run zshell with current config
zsh


