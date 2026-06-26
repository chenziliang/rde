-- LSP via mason + lspconfig, with blink.cmp for completion.
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {
          -- Add the servers you want auto-installed here.
          ensure_installed = { "lua_ls" },
      } },
      "saghen/blink.cmp",
    },
    config = function()
      -- Runs whenever a language server attaches to a buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function m(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          m("gd", vim.lsp.buf.definition, "Goto definition")
          m("gr", function() require("fzf-lua").lsp_references() end, "References")
          m("K", vim.lsp.buf.hover, "Hover docs")
          m("<leader>rn", vim.lsp.buf.rename, "Rename")
          m("<leader>ca", vim.lsp.buf.code_action, "Code action")
          m("<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, "Document symbols")
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- nvim 0.11+ native API: configure defaults for all servers, then enable.
      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.enable({ "lua_ls" })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },     -- <C-y> to accept, <C-n>/<C-p> to cycle
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "lua" },
    },
  },
}
