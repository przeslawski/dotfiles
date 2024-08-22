#!/bin/sh

ln -s -t $HOME/.config $(realpath ./alacritty)
ln -s -t $HOME/.config $(realpath ./nvim)
ln -s -t $HOME $(realpath ./.tmux.conf)
