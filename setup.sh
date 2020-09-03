#!/usr/bin/env bash

ConfigRoot="$(dirname "$(readlink -f "$0")")"/config
echo ConfigRoot: $ConfigRoot

echo Linking settings for nvim...
rm -rvf ~/.config/nvim
ln -svf $ConfigRoot/nvim ~/.config/nvim

echo Linking settings for starship...
rm -vf ~/.config/starship.toml
ln -svf $ConfigRoot/starship/starship.toml ~/.config/starship.toml

echo Linking settings for git...
rm -vf ~/.gitconfig
ln -svf $ConfigRoot/git/.gitconfig ~/.gitconfig

echo Linking settings for tmux...
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -rvf ~/.config/tmux
rm -rvf ~/.tmux.conf
ln -svf $ConfigRoot/tmux/tmux.conf ~/.tmux.conf
