-- lua/plugins/formatting.lua
--
-- conform.nvim: runs external formatters (black, ruff, prettier, ...) on
-- your file, either on demand or automatically on save. This is separate
-- from LSP-based linting (lsp.lua's ruff_lsp catches *problems*; this file
-- just enforces consistent *style* so code review never argues about it).
--
-- mason-tool-installer makes sure the actual formatter binaries are
-- installed on your machine (via mason.nvim) without you doing it by hand.

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ruff", -- Python formatter/linter/import-sorter (used by conform's ruff_format)
        "prettier", -- JS/TS/CSS/Markdown formatter, kept for EkoHacks' frontend repos
        "stylua", -- Lua formatter (standalone Rust binary, no runtime deps)
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- needs to be loaded before a save happens
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
      },
      -- Format automatically whenever you save a file (:w). Set to nil and
      -- use <leader>lf manually if you'd rather review formatting first.
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}
