-- Treesitter: better syntax highlighting and indentation.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",                      -- stable classic API (main branch is a WIP rewrite)
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript",
      "tsx", "json", "yaml", "toml", "markdown", "markdown_inline", "go", "rust",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
