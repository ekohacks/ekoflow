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
--   ruff_lsp -- extremely fast Python linter, also used in formatting.lua
--   ts_ls    -- TypeScript/JS server (kept since EkoHacks also does TS/React)
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
      ensure_installed = { "pyright", "ruff_lsp", "ts_ls", "lua_ls" },
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
      local lspconfig = require("lspconfig")
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
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("<leader>e", vim.diagnostic.open_float, "Show diagnostic in float")
        end,
      })

      -- Python: pyright handles types/navigation; ruff_lsp handles fast
      -- linting. Running both together is the current community-recommended
      -- pairing (ruff is much faster than pylint/flake8 for lint feedback).
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.ruff_lsp.setup({ capabilities = capabilities })

      -- TypeScript/JS, kept for EkoHacks' React/Redux codebases.
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      -- Lua, so working inside THIS config has full autocomplete for the
      -- Neovim API (vim.*, etc). `vim` global is otherwise flagged unknown.
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
    end,
  },
}
