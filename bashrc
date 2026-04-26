# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=~/.cache/bash-history
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# import personal aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export INPUTRC=/home/benferse/.config/readline/inputrc

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Starship integration
if [ -x "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# direnv integration
if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

# Ubuntu + GNOME + Wayland == sad
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# BEGIN Agency MANAGED BLOCK
if [[ ":${PATH}:" != *":/home/benferse/.config/agency/CurrentVersion:"* ]]; then
    export PATH="/home/benferse/.config/agency/CurrentVersion:${PATH}"
fi
# END Agency MANAGED BLOCK

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "/home/benferse/.cargo/env"

# Intune AI Bootstrap ACP launcher
[ -f "/home/benferse/.copilot/acp-profile.sh" ] && source "/home/benferse/.copilot/acp-profile.sh"
