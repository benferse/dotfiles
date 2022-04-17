#!/usr/bin/env bash

# Load any host specific modifications first
if [ -f ~/.xinitrc.local ]; then
    . ~/.xinitrc.local
fi

# Control keys? In my caps lock? It's more likely than you'd think
setxkbmap -option caps:ctrl_modifier

# Compositor
picom &

# Wallpaper
feh --no-fehbg --bg-scale ~/.local/share/backgrounds/ninja_cat_at_night.jpg &

# Status bar
# TODO Work in progress
benbar &

# Start dwm
exec dwm
