-- Sane, low-clutter defaults.
local opt = vim.opt

vim.g.mapleader = ","            -- match long-standing muscle memory from ~/.vimrc
vim.g.maplocalleader = ","

opt.number = true
opt.relativenumber = true        -- relative line numbers for quick motions
opt.signcolumn = "yes"           -- stable gutter, no layout shift
opt.cursorline = true
opt.scrolloff = 8                 -- keep context around the cursor
opt.wrap = false

opt.expandtab = true             -- spaces, not tabs
opt.shiftwidth = 4               -- global default (per-language overrides in from-vimrc.lua)
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true             -- case-sensitive only if query has caps
opt.incsearch = true
opt.hlsearch = false

opt.splitright = true
opt.splitbelow = true

opt.undofile = true              -- persistent undo
opt.swapfile = false
opt.updatetime = 200
opt.timeoutlen = 400

-- Use the terminal's 16 ANSI colors (like classic Vim), not 24-bit truecolor.
-- Apple Terminal can't do truecolor, so this also fixes washed-out GUI themes.
opt.termguicolors = false
opt.showmode = false             -- mode shown in statusline instead
opt.laststatus = 3               -- single global statusline (less clutter)
opt.pumheight = 10               -- shorter completion popup
opt.winborder = "rounded"

opt.clipboard = "unnamedplus"    -- use system clipboard

-- Classic Vim default colorscheme (uses the 16 terminal colors).
vim.cmd.colorscheme("vim")

-- Brief highlight on yank, so you can see what you copied.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})
