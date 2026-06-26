#!/bin/bash
# macOS dev-environment bootstrap. Idempotent — safe to re-run.
# See MACOS-SETUP.md for the full write-up.
set -euo pipefail

REPO="$HOME/code/rde"
cd "$REPO"

echo "==> Homebrew formulae"
brew install neovim fzf fd lazygit ripgrep tmux zsh-autosuggestions

echo "==> Homebrew casks (terminal + fonts)"
brew install --cask wezterm font-hack-nerd-font font-jetbrains-mono-nerd-font

echo "==> Symlink configs (~/.config)"
mkdir -p "$HOME/.config"
ln -sfn "$REPO/config/nvim"    "$HOME/.config/nvim"
ln -sfn "$REPO/config/wezterm" "$HOME/.config/wezterm"

echo "==> Symlink home dotfiles (\$HOME)"
for f in .zshrc .vimrc .tmux .tmux.conf .tmux_local.conf .dir_colors .gdbinit .lldbinit .alias .alias_local .bashrc_local; do
  [ -e "$REPO/home/$f" ] && ln -sfn "$REPO/home/$f" "$HOME/$f"
done
# gdb pretty-printer is referenced by .gdbinit at $HOME level
ln -sfn "$REPO/home/pretty-printer-libcxx-gdb" "$HOME/pretty-printer-libcxx-gdb"

echo "==> Symlink global agent instructions (\$HOME)"
for f in AGENTS.md OPINIONS.md VOICE.md; do
  ln -sfn "$REPO/home/$f" "$HOME/$f"
done
mkdir -p "$HOME/.claude"
ln -sfn "$REPO/home/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"   # makes AGENTS.md global for Claude Code

echo "==> WezTerm font smoothing (heavier strokes, matches Apple Terminal)"
defaults write com.github.wez.wezterm AppleFontSmoothing -int 2

cat <<'DONE'

==> Done.
Next:
  1. Open WezTerm (Cmd-Space → WezTerm).
  2. Run `nvim` — first launch installs plugins from config/nvim/lazy-lock.json.
  3. `source ~/.zshrc` or open a new shell to activate autosuggestions.
DONE
