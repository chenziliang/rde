-- Persistent left-side folder tree (NERDTree-style). Toggle with ,n
-- Configured WITHOUT Nerd Font icons: plain ▸/▾ expander arrows (which render
-- in Menlo) so it works in Terminal.app and WezTerm alike — no tofu glyphs.
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,                           -- load at startup so it always handles directories
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    -- Disable netrw entirely; neo-tree is the directory handler.
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    { "<leader>n", "<cmd>Neotree toggle left<CR>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>Neotree focus<CR>",       desc = "Focus file tree" },
    { "<leader>gf", "<cmd>Neotree reveal<CR>",     desc = "Reveal current file in tree" },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    default_component_configs = {
      indent = {
        with_markers = true,
        with_expanders = true,
        expander_collapsed = "▸",
        expander_expanded = "▾",
      },
      icon = {
        -- No glyph icons; folders are shown by the expander arrow + trailing slash.
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
        provider = function(icon)
          icon.text = ""        -- blank every file/folder icon (no devicons)
          icon.highlight = "NeoTreeFileIcon"
        end,
      },
      git_status = {
        -- Plain ASCII markers instead of Nerd Font glyphs.
        symbols = {
          added = "+", modified = "~", deleted = "✗", renamed = "→",
          untracked = "?", ignored = "i", unstaged = "u", staged = "s", conflict = "!",
        },
      },
    },
    window = { position = "left", width = 32 },
    filesystem = {
      hijack_netrw_behavior = "open_current",  -- nvim <dir> opens neo-tree here
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      -- Append "/" to directory names (the NERDTree look).
      components = {
        name = function(config, node, state)
          local cc = require("neo-tree.sources.common.components")
          local result = cc.name(config, node, state)
          if node.type == "directory" then
            result.text = result.text .. "/"
          end
          return result
        end,
      },
    },
  },
}
