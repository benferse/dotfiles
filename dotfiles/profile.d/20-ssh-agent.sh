# Use GPG agent as SSH agent
if command -v gpgconf >/dev/null 2>&1; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
