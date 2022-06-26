# Always favor the gpg-agent's ssh socket, and make sure
# to use gpgconf(1) to find it. If you set GNUPGHOME, gpg
# components will add an extra subdir to the socket path
# (specifically, first 10 bytes of the hash of the full
# value of GNUPGHOME, encoded with the Zooko variant of
# base32, because why wouldn't they, right?).
export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
