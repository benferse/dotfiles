#!/usr/bin/env bash

# Inject any preferences into the resource manager
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set various default programs
export TERMINAL='kitty'
export WEBBROWSER='/usr/bin/microsoft-edge --force-device-scale-factor=2'

# Load any host specific modifications first
if [ -f ~/.xinitrc.local ]; then
    . ~/.xinitrc.local
fi

# Control keys? In my caps lock? It's more likely than you'd think
setxkbmap -option caps:ctrl_modifier

# Compositor
picom &

# Wallpaper
feh --no-fehbg --bg-scale ~/.local/share/backgrounds/nord_mountains.png &

# Status bar
# TODO Work in progress
# ingot &
polybar &

# Notifications
# TODO Work in progress as well
dunst &

# Input
sxhkd &

# Start dwm
exec bspwm
