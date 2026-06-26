-- Filesystem-as-buffer editing (oil) + small quality-of-life helpers.
return {
  {
    "stevearc/oil.nvim",                  -- edit directories like a normal buffer
    cmd = "Oil",
    opts = {
      default_file_explorer = false,      -- let neo-tree handle directory opening
      view_options = { show_hidden = true },
      keymaps = { ["<C-h>"] = false },    -- keep window-nav binding
    },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
    },
  },

  { "echasnovski/mini.pairs", version = false, event = "InsertEnter", opts = {} },
  { "echasnovski/mini.surround", version = false, keys = { "sa", "sd", "sr" }, opts = {} },

  {
    "folke/todo-comments.nvim",           -- highlight TODO/FIXME/NOTE
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
