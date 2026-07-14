#!/bin/bash
# macOS dev-environment bootstrap. Idempotent — safe to re-run.
# See MACOS-SETUP.md for the full write-up.
set -euo pipefail

REPO="$HOME/code/rde"
cd "$REPO"

echo "==> Homebrew formulae"
brew install neovim fzf fd lazygit ripgrep tmux zsh-autosuggestions awscli

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

echo "==> Vim: Vundle plugin manager + plugins"
# .vimrc guards on this directory, so vim degrades gracefully without it.
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
vim +PluginInstall +qall >/dev/null 2>&1 </dev/null || true

echo "==> Symlink global agent instructions (\$HOME)"
for f in AGENTS.md OPINIONS.md VOICE.md; do
  ln -sfn "$REPO/home/$f" "$HOME/$f"
done
mkdir -p "$HOME/.claude"
ln -sfn "$REPO/home/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"   # makes AGENTS.md global for Claude Code

echo "==> WezTerm font smoothing (heavier strokes, matches Apple Terminal)"
defaults write com.github.wez.wezterm AppleFontSmoothing -int 2

echo "==> Agentic tools: treehouse (parallel git worktrees for AI agents)"
# Pinned + checksum-verified install (NOT `curl|sh` or `go install @latest`).
# To bump: update TREEHOUSE_VER and TREEHOUSE_SHA256 (from the release checksums.txt).
# Note: `treehouse update` self-updates and drifts from this pin — re-run instead.
TREEHOUSE_VER="v2.0.0"
TREEHOUSE_SHA256="66022f36eb0c79d6f242025f266b782ac947b3a2817005f13425cbd18874f1f9"  # darwin-arm64
if [ "$(uname -sm)" = "Darwin arm64" ]; then
  tmp="$(mktemp -d)"
  url="https://github.com/kunchenguid/treehouse/releases/download/${TREEHOUSE_VER}/treehouse-${TREEHOUSE_VER}-darwin-arm64.tar.gz"
  curl -fsSL -o "$tmp/th.tar.gz" "$url"
  got="$(shasum -a 256 "$tmp/th.tar.gz" | awk '{print $1}')"
  if [ "$got" = "$TREEHOUSE_SHA256" ]; then
    tar -xzf "$tmp/th.tar.gz" -C "$tmp"
    mkdir -p "$HOME/.local/bin"
    install -m 0755 "$tmp/treehouse" "$HOME/.local/bin/treehouse"
    echo "    installed treehouse ${TREEHOUSE_VER} -> ~/.local/bin/treehouse"
  else
    echo "    !! checksum mismatch ($got) — skipping treehouse install" >&2
  fi
  rm -rf "$tmp"
else
  echo "    (skipped: not darwin-arm64)"
fi

cat <<'DONE'

==> Done.
Next:
  1. Open WezTerm (Cmd-Space → WezTerm).
  2. Run `nvim` — first launch installs plugins from config/nvim/lazy-lock.json.
  3. `source ~/.zshrc` or open a new shell to activate autosuggestions.
DONE
