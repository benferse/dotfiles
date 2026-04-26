# per-user config for Bourne-like shells
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists. this way, we don't have
  # to do a lot of thinking of whether this is a login shell
  # or a non-login shell. they all just work the same
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/.local/bin ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# per-tag and per-host profile extensions
for p in ~/.profile.d/*.sh; do
  . "$p"
done

. "$HOME/.cargo/env"
