-- lua/plugins/treesitter.lua
--
-- Treesitter builds a real syntax tree of your code (instead of guessing
-- with regex like old Vim syntax highlighting did). This gives us: better
-- highlighting, smarter indentation, and structural text objects (e.g.
-- "select this whole function").

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- after install/update, compile the language parsers
  event = { "BufReadPost", "BufNewFile" }, -- load when you actually open a file
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Parsers to install automatically. We prioritize Python (incl. common
      -- bioinformatics file adjacent formats) but keep JS/TS since EkoHacks
      -- also ships TypeScript/React work.
      ensure_installed = {
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
      },
      auto_install = true, -- install a parser on-the-fly if you open an unlisted filetype
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
