-- Neogit: a Magit-style git interface (status, stage/unstage, commit, push,
-- branch, log) all from one buffer. Pairs with diffview for rich diffs.
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",          -- side-by-side / file-history diffs
    "ibhagwan/fzf-lua",                -- pickers (you already use fzf-lua)
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>",                desc = "Neogit (git status)" },
    { "<leader>gs", "<cmd>Neogit<CR>",                desc = "Neogit (git status)" },
    { "<leader>gc", "<cmd>Neogit commit<CR>",         desc = "Neogit commit" },
    { "<leader>gl", "<cmd>Neogit log<CR>",            desc = "Neogit log" },
    { "<leader>gp", "<cmd>Neogit pull<CR>",           desc = "Neogit pull" },
    { "<leader>gP", "<cmd>Neogit push<CR>",           desc = "Neogit push" },
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "Diffview (working tree)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current file)" },
  },
  opts = {
    graph_style = "unicode",           -- renders without a Nerd Font
    integrations = {
      diffview = true,
      fzf_lua = true,
    },
  },
}
