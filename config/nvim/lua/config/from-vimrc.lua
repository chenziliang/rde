-- Ported from the old ~/.vimrc (plugin-independent bits only).
-- The Vundle/pathogen/YCM/ctrlp/NERDTree/vim-go parts were intentionally
-- dropped: those plugins aren't installed here and have modern equivalents
-- (fzf-lua, oil, LSP, blink.cmp, treesitter).
local opt = vim.opt
local map = vim.keymap.set
local aug = vim.api.nvim_create_augroup("FromVimrc", { clear = true })

-- General behavior (.vimrc lines 18-39)
opt.history = 1000
opt.autoread = true              -- reload files changed outside nvim
opt.showmatch = true             -- briefly jump to matching bracket
opt.colorcolumn = "80"           -- highlight column 80 (line 86)

-- Re-check the file when regaining focus / entering a buffer (pairs with autoread)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = aug,
  command = "silent! checktime",
})

-- Strip trailing whitespace on save (line 100), preserving cursor position.
-- Skipped for filetypes where trailing space can be meaningful.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug,
  callback = function()
    if vim.tbl_contains({ "markdown", "diff", "gitsendemail" }, vim.bo.filetype) then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Jump to last known cursor position when opening a file (lines 112-117)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug,
  callback = function(args)
    if vim.bo[args.buf].filetype == "gitcommit" then return end
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Insert-mode line jumps (lines 138-139)
map("i", "<C-a>", "<C-o>0", { desc = "Start of line" })
map("i", "<C-e>", "<C-o>$", { desc = "End of line" })

-- Tabs (lines 153-156). Leader is now <Space>, originally ","
map("n", "<leader>tn", "<cmd>tabnew %<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Buffer navigation (lines 183-185)
map("n", "<leader>bn", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>",       { desc = "Alternate buffer" })

-- Window resize (lines 352-356)
map("n", "<leader>]", "<cmd>vertical resize +8<CR>", { desc = "Widen window" })
map("n", "<leader>[", "<cmd>vertical resize -8<CR>", { desc = "Narrow window" })
map("n", "<leader>}", "<cmd>resize +8<CR>",          { desc = "Taller window" })
map("n", "<leader>{", "<cmd>resize -8<CR>",          { desc = "Shorter window" })

-- Per-language indentation overrides (your global default is 4 spaces).
-- These follow each language's own convention.
local indent = {
  lua = 2, javascript = 2, typescript = 2, typescriptreact = 2,
  json = 2, yaml = 2, html = 2, css = 2, markdown = 2,
}
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  callback = function(args)
    local w = indent[vim.bo[args.buf].filetype]
    if w then
      vim.bo[args.buf].shiftwidth = w
      vim.bo[args.buf].tabstop = w
      vim.bo[args.buf].softtabstop = w
    end
  end,
})

-- Go convention: real tabs (.vimrc line 226). expandtab off + width 4.
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = "go",
  callback = function(args)
    vim.bo[args.buf].expandtab = false
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].tabstop = 4
  end,
})
