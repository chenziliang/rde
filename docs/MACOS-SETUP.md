# macOS Dev Environment — Setup & Fine-Tuning

Replication guide for this Mac terminal/editor setup (Neovim + WezTerm + tmux +
zsh). Everything lives in this `rde` repo and is symlinked into place, so a new
laptop is: clone → run `setup-macos.sh` → done.

## What's fine-tuned (at a glance)

| Area | Summary |
|------|---------|
| **Neovim** | Custom config (`config/nvim/`): lazy.nvim, fzf-lua, neo-tree (single file explorer, NERDTree-style, icon-free), oil (on-demand), Neogit, render-markdown, treesitter, LSP+mason+blink.cmp. **Comma leader.** Classic `vim` colorscheme on the 16-color terminal palette. |
| **WezTerm** | `config/wezterm/wezterm.lua`: colors/font/size matched to the Apple Terminal "MyPro" profile (Menlo 12, `#424242` bg, green cursor, 150×60), Hack Nerd Font fallback for icons, opaque. |
| **tmux** | `.tmux.conf`: prefix `Ctrl-a`, vim-style pane nav (`h/j/k/l`). |
| **zsh** | `.zshrc`: fish-style inline history hints via `zsh-autosuggestions` (accept with →). |
| **Fonts** | Hack Nerd Font + JetBrainsMono Nerd Font (Nerd Font glyphs for icons). |

## Prerequisites

- macOS (Apple Silicon)
- [Homebrew](https://brew.sh)
- `git`, and this repo cloned to `~/code/rde`

## Replication steps

```sh
git clone git@github.com:chenziliang/rde.git ~/code/rde
cd ~/code/rde
./scripts/setup-macos.sh   # installs brew pkgs, symlinks configs, sets font smoothing
```

Then:

1. **Open WezTerm** (not Apple Terminal) for the full experience.
2. **Run `nvim`** — on first launch lazy.nvim installs all plugins from the
   pinned `config/nvim/lazy-lock.json`, then it's instant.
3. `source ~/.zshrc` (or open a new shell) to activate autosuggestions.

### What `setup-macos.sh` does

- **brew formulae:** `neovim fzf fd lazygit ripgrep tmux zsh-autosuggestions`
- **brew casks:** `wezterm font-hack-nerd-font font-jetbrains-mono-nerd-font`
- **Symlinks:**
  - `~/.config/nvim`    → `~/code/rde/config/nvim`
  - `~/.config/wezterm` → `~/code/rde/config/wezterm`
  - `~/.zshrc`, `~/.vimrc`, `~/.tmux.conf`, … → `~/code/rde/home/<dotfile>`
- **WezTerm font smoothing:** `defaults write com.github.wez.wezterm AppleFontSmoothing -int 2`

## Key decisions & gotchas (learned the hard way)

- **`nvim` ≠ `vim`.** `vim` is aliased to real Vim using the legacy `~/.vimrc`.
  The modern setup is **`nvim`** only. They are intentionally separate.
- **Leader is comma (`,`)** to preserve old Vim muscle memory. `,,` = find files
  (like the old ctrlp binding). See the XBrain cheatsheets for the full map.
- **`termguicolors = false`** on purpose: Apple Terminal can't do 24-bit
  truecolor, so we use the terminal's 16 ANSI colors + the built-in `vim`
  colorscheme. This looks like classic Vim and renders correctly in *both*
  Apple Terminal and WezTerm. (Truecolor themes look washed-out in Terminal.app.)
- **WezTerm matches the Apple Terminal "MyPro" profile** (colors/font/size were
  extracted from `com.apple.Terminal.plist` and replicated). Menlo has no
  Nerd Font glyphs, so WezTerm uses **font fallback** (Menlo → Hack Nerd Font)
  to get icons while keeping Menlo text. Apple Terminal can't fall back, so
  icons (neo-tree etc.) are tofu there — use WezTerm for icons.
- **neo-tree is the single file explorer** (icon-free, `▸`/`▾` arrows render in
  Menlo, no Nerd Font needed). oil is demoted to on-demand (`-`) and no longer
  hijacks directory opening.
- **render-markdown** heading colors are hand-tuned for 16-color mode (bold
  colored text, no harsh background bars) in `config/nvim/lua/plugins/markdown.lua`.

## Keybinding references

Full cheatsheets live in the XBrain wiki (`~/code/XBrain/wiki/tools/`):
`nvim-keybindings.md`, `tmux-shortcuts.md`, `neogit-shortcuts.md`.

## Layout

```
rde/
├── README.md
├── home/               # $HOME dotfiles (symlinked into ~): .zshrc .vimrc
│   │                   #   .tmux.conf .alias* .gdbinit .lldbinit ...
│   └── pretty-printer-libcxx-gdb/   # gdb libc++ pretty-printer (used by .gdbinit)
├── config/             # ~/.config/* (symlinked)
│   ├── nvim/           #   → ~/.config/nvim
│   └── wezterm/        #   → ~/.config/wezterm
├── docker/             # Dockerfile.* dev-container images
├── scripts/            # setup.sh (Linux), setup-macos.sh, setup-tools.sh, rde
└── docs/               # cheatsheet, MACOS-SETUP.md (this file)
```
