# dotfiles

Cross-platform configuration managed by [nostos](https://github.com/benferse/nostos).

## What's here

- Shell: bash, zsh, profile, profile.d scripts
- Terminal: [kitty](https://sw.kovidgoat.net/kitty/)
- Prompt: [starship](https://starship.rs)
- Editor: [neovim](https://neovim.io) (LazyVim)
- Git: core config (identity managed externally per-machine)
- GnuPG: agent, key, and smartcard config

## Layout

```
dotfiles/           Active config (nostos source directory)
  config/           Maps to ~/.config/
  gnupg/            Maps to ~/.gnupg/
  profile.d/        Maps to ~/.profile.d/
  platforms/macos/  macOS-specific overrides
nostos.toml         nostos configuration
stash/              Archived config (preserved in git history)
```

## Usage

```sh
# Preview what nostos will deploy
nostos plan

# Apply config to the home directory
nostos apply
```

## Platform overrides

macOS uses a different `gpg-agent.conf` (pinentry-mac). This is declared in
`nostos.toml` under `[dotfiles.platforms.macos]` and applied automatically
when running on macOS.
