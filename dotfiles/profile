# Login environment for all shells (bash, zsh).
# Sourced by: bash_profile, zprofile
#
# Rules:
#   - Exported env vars and PATH → here (or profile.d/)
#   - Interactive config → ~/.shellrc

# per-user config for Bourne-like shells
umask 022

# set PATH so it includes user's private bin if it exists
if [ -d ~/.local/bin ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Homebrew (macOS or Linux)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# per-tag and per-host profile extensions
for p in ~/.profile.d/*.sh; do
  [ -f "$p" ] && . "$p"
done
