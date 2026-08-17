-- lua/plugins/lsp.lua
--
-- LSP = Language Server Protocol. A language server is a separate process
-- (e.g. `pyright`) that understands your code and answers questions like
-- "where is this defined?" or "what's wrong on this line?" over a standard
-- protocol. Neovim ships a built-in LSP *client*; these plugins install
-- servers and wire the client up to them.
--
-- Stack here (Python-first, per EkoHacks priority):
--   mason.nvim          -- package manager for LSP servers/linters/formatters
--   mason-lspconfig.nvim -- bridges mason <-> nvim-lspconfig naming
--   nvim-lspconfig       -- ready-made configs for dozens of language servers
--
--   pyright  -- Python type checking & navigation (Microsoft's server)
--   ruff -- extremely fast Python linter, also used in formatting.lua
--   vtsls    -- TypeScript/JS server wrapper (better auto-import than ts_ls)
--   lua_ls   -- so editing THIS config gets autocomplete for the Neovim API

return {
  {
    "williamboman/mason.nvim",
    config = true, -- shorthand for config = function() require("mason").setup() end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "ruff", "vtsls", "lua_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- lets completion.lua's engine talk to LSP
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps that apply once ANY language server attaches to a buffer.
      -- This runs per-buffer, so it only activates where an LSP is active.
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keymaps on attach",
        callback = function(event)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Find references")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          -- Import helpers. `source.addMissingImports` is a TypeScript source
          -- action (adds every unimported symbol at once); `source.organizeImports`
          -- sorts and prunes. `apply = true` runs the action without prompting.
          map("<leader>ia", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.addMissingImports" } },
              apply = true,
            })
          end, "Add missing imports")
          map("<leader>io", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
          end, "Organize imports")
          -- Nvim 0.11+ replaced diagnostic.goto_prev/goto_next with jump().
          map("[d", function()
            vim.diagnostic.jump({ count = -1 })
          end, "Previous diagnostic")
          map("]d", function()
            vim.diagnostic.jump({ count = 1 })
          end, "Next diagnostic")
          map("<leader>e", vim.diagnostic.open_float, "Show diagnostic in float")
        end,
      })

      -- Nvim 0.11+ ships a native LSP config API (vim.lsp.config / .enable),
      -- so nvim-lspconfig's old `lspconfig.<server>.setup{}` framework is
      -- deprecated. nvim-lspconfig now just ships base configs under lsp/ that
      -- vim.lsp.enable() picks up; we layer our overrides on with
      -- vim.lsp.config(). See :help lspconfig-nvim-0.11.

      -- Shared defaults for every server: give the completion engine's
      -- capabilities to all of them at once via the "*" wildcard.
      vim.lsp.config("*", { capabilities = capabilities })

      -- Lua, so working inside THIS config has full autocomplete for the
      -- Neovim API (vim.*, etc). `vim` global is otherwise flagged unknown.
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Turn on autostart for our servers. Python: pyright handles
      -- types/navigation; ruff handles fast linting (much faster than
      -- pylint/flake8). vtsls (the maintained TypeScript server wrapper, better
      -- auto-import & code actions than the older ts_ls) for React/TS work.
      vim.lsp.enable({ "pyright", "ruff", "vtsls", "lua_ls" })
    end,
  },
}
