# rde — dotfiles & dev environment

Personal dotfiles, editor/terminal configs, and dev-container setup.
Everything is symlinked into place from this repo so machines stay reproducible.

## Layout

| Path | What |
|------|------|
| `home/` | `$HOME` dotfiles (symlinked into `~`): `.zshrc`, `.vimrc`, `.tmux.conf`, `.alias*`, `.gdbinit`, `.lldbinit`, plus the gdb libc++ pretty-printer. |
| `config/` | `~/.config/*` app configs: `nvim/`, `wezterm/`. |
| `docker/` | `Dockerfile.*` dev-container images. |
| `scripts/` | `setup.sh` (Linux bootstrap), `setup-macos.sh` (macOS bootstrap), `setup-tools.sh`, `rde` (docker dev-env launcher). |
| `docs/` | `cheatsheet`, `MACOS-SETUP.md`. |

## Quick start

**macOS:**
```sh
git clone git@github.com:chenziliang/rde.git ~/code/rde
cd ~/code/rde && ./scripts/setup-macos.sh
```
See [docs/MACOS-SETUP.md](docs/MACOS-SETUP.md) for the full write-up and the
fine-tuning rationale (Neovim, WezTerm, tmux, zsh).

`MyPro.terminal` is the MacOS terminal profile which is used by default.

**Linux / dev container:** see `scripts/setup.sh`.

## Notes

- `home/` and `config/` files are the single source of truth; the copies in
  `~` and `~/.config` are symlinks back here.
- Keybinding cheatsheets for nvim/tmux/Neogit live in the XBrain wiki
  (`~/code/XBrain/wiki/tools/`).
