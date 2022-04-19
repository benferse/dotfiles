umask 022

export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export VISUAL='nvr -s --remote-wait-silent'
export TERMINAL='st -e scroll'
export WEBBROWSER='microsoft-edge-dev --force-device-scale-factor=2'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
    . ~/.bashrc
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/.local/bin ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# if cargo is installed, then add its environment to the path
if [ -f ~/.cargo/env ] ; then
    . ~/.cargo/env
fi

# always favor the gpg-agent's ssh socket
export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# if we have neovim and neovim-remote, set up a known
# socket for the server to listen on
if [ -x ~/.local/bin/nvim -a -x ~/.local/bin/nvr ] ; then
    export NVIM_LISTEN_ADDRESS=${XDG_RUNTIME_DIR}/nvim.sock
fi

# Set various default programs
export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export TERMINAL='st -e scroll'
export WEBBROWSER='/usr/bin/microsoft-edge --force-device-scale-factor=2'
