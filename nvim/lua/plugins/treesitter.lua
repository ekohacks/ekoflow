-- lua/plugins/treesitter.lua
--
-- Treesitter builds a real syntax tree of your code (instead of guessing
-- with regex like old Vim syntax highlighting did). This gives us: better
-- highlighting, smarter indentation, and structural text objects (e.g.
-- "select this whole function").
--
-- We are on the `main` branch. The old `master` branch is EOL and does NOT
-- support Neovim 0.11+ (its own README caps out at 0.10/0.11) -- on Neovim
-- 0.12 it throws `attempt to call method 'range' (a nil value)`. `main` is the
-- rewrite and the supported path going forward. Its API is different: there is
-- no `configs.setup{ highlight = ..., indent = ... }`. Instead you install
-- parsers with `.install{}`, and highlighting/indentation are enabled
-- per-buffer via Neovim's own `vim.treesitter.start()` and this plugin's
-- `indentexpr()`. Building parsers on this branch requires the `tree-sitter`
-- CLI (>= 0.26.1) and a C compiler on PATH.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate", -- keep installed parsers in sync with the plugin
  lazy = false, -- treesitter underpins highlighting; load it eagerly
  config = function()
    require("nvim-treesitter").setup()

    -- Parsers to install. On `main` this is an explicit, asynchronous install
    -- call rather than an `ensure_installed` option; it is a no-op for parsers
    -- that are already present. We prioritize Python but keep the JS/TS family
    -- and the usual config/markup languages.
    require("nvim-treesitter").install({
      "python",
      "lua",
      "markdown",
      "markdown_inline",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",
      "toml",
      "bash",
      "vim",
      "vimdoc",
    })

    -- `main` does not auto-enable anything. Turn on treesitter highlighting
    -- (provided by Neovim core) and the plugin's experimental treesitter
    -- indentation whenever we open a buffer whose language has a parser.
    -- `vim.treesitter.start()` infers the language from the buffer's filetype
    -- and is a no-op when no parser is installed, so the pcall guard keeps a
    -- missing parser from ever erroring on BufEnter.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if pcall(vim.treesitter.start) then
          vim.bo[args.buf].indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
