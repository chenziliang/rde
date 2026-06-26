-- Fuzzy find + live grep with fzf-lua. The heart of the terminal-centric flow.
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader><leader>", function() require("fzf-lua").files() end,      desc = "Find files" },
    { "<leader>ff",       function() require("fzf-lua").files() end,      desc = "Find files" },
    { "<leader>fg",       function() require("fzf-lua").live_grep() end,  desc = "Live grep" },
    { "<leader>fw",       function() require("fzf-lua").grep_cword() end, desc = "Grep word under cursor" },
    { "<leader>fb",       function() require("fzf-lua").buffers() end,    desc = "Buffers" },
    { "<leader>fh",       function() require("fzf-lua").helptags() end,   desc = "Help tags" },
    { "<leader>fr",       function() require("fzf-lua").resume() end,     desc = "Resume last search" },
    { "<leader>fd",       function() require("fzf-lua").diagnostics_document() end, desc = "Diagnostics" },
  },
  opts = {
    "border-fused",
    fzf_colors = true,
    winopts = { height = 0.85, width = 0.85, preview = { layout = "vertical" } },
  },
}
