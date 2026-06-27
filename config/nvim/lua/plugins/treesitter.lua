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
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- Compat shim: nvim-treesitter `master` is archived at v0.10 and predates the
    -- Neovim 0.11+ change where a directive's `match[id]` became a TSNode[] array
    -- instead of a single node. Its `set-lang-from-info-string!` handler (used by
    -- the markdown code-block injection query) crashes on 0.12 with
    -- "attempt to call method 'range' (a nil value)". Re-register it to handle the
    -- array form. (Load their version first so our forced override wins.)
    pcall(require, "nvim-treesitter.query_predicates")
    local alias = {
      js = "javascript", ts = "typescript", py = "python", sh = "bash",
      shell = "bash", rs = "rust", yml = "yaml", ["c++"] = "cpp", golang = "go",
    }
    vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local node = match[pred[2]]
      if type(node) == "table" then node = node[#node] end  -- 0.11+: array of nodes
      if not node then return end
      local lang = vim.treesitter.get_node_text(node, bufnr):lower()
      metadata["injection.language"] = alias[lang] or lang
    end, { force = true })
  end,
}
