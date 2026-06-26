-- render-markdown.nvim: in-buffer Markdown rendering (styled headings with
-- level icons, ● bullets, boxed code blocks, rendered tables/checkboxes).
-- This is the plugin from Kun Chen's video.
return {
  { "echasnovski/mini.icons", version = false, opts = {} },  -- icon provider

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    opts = {
      heading = {
        position = "inline",
        -- Don't paint full-width background bars (they map to harsh ANSI
        -- colors in 16-color mode). Headings get colored + bold text instead.
        width = "block",
        backgrounds = {},   -- no Hn background highlight
      },
      code = {
        style = "normal",   -- no language-icon header bar; keep it plain
        border = "thin",
      },
      completions = { lsp = { enabled = true } },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Subtle, terminal-palette-friendly colors (works with termguicolors off).
      local function tune()
        local set = vim.api.nvim_set_hl
        -- Heading text: distinct cterm colors, bold, NO background.
        set(0, "RenderMarkdownH1", { ctermfg = 4, bold = true })  -- blue
        set(0, "RenderMarkdownH2", { ctermfg = 2, bold = true })  -- green
        set(0, "RenderMarkdownH3", { ctermfg = 3, bold = true })  -- yellow
        set(0, "RenderMarkdownH4", { ctermfg = 6, bold = true })  -- cyan
        set(0, "RenderMarkdownH5", { ctermfg = 5, bold = true })  -- magenta
        set(0, "RenderMarkdownH6", { ctermfg = 7, bold = true })  -- white
        for i = 1, 6 do
          set(0, "RenderMarkdownH" .. i .. "Bg", { ctermbg = "NONE" })
        end
        -- Code: no loud background; just dim the fences, color inline code.
        set(0, "RenderMarkdownCode", { ctermbg = "NONE" })
        set(0, "RenderMarkdownCodeInline", { ctermfg = 2, ctermbg = "NONE" })
        set(0, "RenderMarkdownBullet", { ctermfg = 4 })
        set(0, "RenderMarkdownDash", { ctermfg = 8 })
        -- Tame the column-80 marker that was showing as a bright bar.
        set(0, "ColorColumn", { ctermbg = 0 })
      end

      tune()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = tune })
    end,
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
    },
  },
}
