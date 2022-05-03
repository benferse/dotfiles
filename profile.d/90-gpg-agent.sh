# always favor the gpg-agent's ssh socket
ssh_sock="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
if [ -S $ssh_sock ]; then
    export SSH_AUTH_SOCK=$ssh_sock
fi
