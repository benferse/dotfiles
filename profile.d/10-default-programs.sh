# Set various default programs

have_command() {
    command -v "$1" >/dev/null 2>&1
}

if have_command nvr; then
    export EDITOR='nvr -s --remote-wait-silent'
    export GIT_EDITOR='nvr -s --remote-wait-silent'
    export NVIM_LISTEN_ADDRESS=${XDG_RUNTIME_DIR}/nvim.sock
fi

if have_command st; then
    export TERMINAL='st -e scroll'
fi

if have_command microsoft-edge; then
    export WEBBROWSER='microsoft-edge --force-device-scale-factor=2'
fi
