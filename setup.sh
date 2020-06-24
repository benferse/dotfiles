#!/usr/bin/env bash

ConfigRoot="$(cd $(dirname ${BASH_SOURCE[0]}) >/dev/null 2>&1 && pwd)"/config
echo ConfigRoot: $ConfigRoot

echo Linking settings for nvim...
rm -rf ~/.config/nvim
ln -s $ConfigRoot/nvim ~/.config/nvim

echo Linking settings for starship...
rm -f ~/.config/starship.toml
ln -s $ConfigRoot/starship/starship.toml ~/.config/starship.toml

echo Linking settings for git...
rm -f ~/.gitconfig
ln -s $ConfigRoot/git/.gitconfig ~/.gitconfig
