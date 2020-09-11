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
ln -svf $ConfigRoot/git/gitconfig ~/.gitconfig

echo Linking settings for tmux...
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -rvf ~/.config/tmux
rm -rvf ~/.tmux.conf
ln -svf $ConfigRoot/tmux/tmux.conf ~/.tmux.conf

echo Linking settings for bash...
[ -f ~/.bashrc ]       && mv -vf ~/.bashrc ~/.bashrc.orig
[ -f ~/.profile ]      && mv -vf ~/.profile ~/.profile.orig
[ -f ~/.bash_profile ] && mv -vf ~/.bash_profile ~/.bash_profile.orig
[ -f ~/.bash_logout ]  && mv -vf ~/.bash_logout ~/.bash_logout.orig

ln -svf $ConfigRoot/bash/bashrc ~/.bashrc
ln -svf $ConfigRoot/bash/profile ~/.profile
ln -svf $ConfigRoot/bash/bash_logout ~/.bash_logout
rm -vf ~/.bash_profile

echo Linking settings for dircolors...
rm -vf ~/.dircolors
ln -svf $ConfigRoot/dircolors/nord.dircolors ~/.dircolors

echo Linking settings for readline...
rm -vf ~/.inputrc
ln -svf $ConfigRoot/readline/inputrc ~/.inputrc
