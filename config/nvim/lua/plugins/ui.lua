-- Look & feel: a muted, low-contrast theme and a minimal statusline.
return {
  {
    "echasnovski/mini.statusline",        -- tiny statusline, no icons-overload
    version = false,
    config = function()
      require("mini.statusline").setup({ use_icons = false })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",            -- subtle git signs in the gutter
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" }, change = { text = "│" },
        delete = { text = "_" }, topdelete = { text = "‾" }, changedelete = { text = "~" },
      },
    },
  },
}
