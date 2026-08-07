-- lua/plugins/ui.lua
--
-- Purely visual plugins: colorscheme, statusline, icons. No editing behavior
-- lives here — that's a deliberate separation so you can swap the look of
-- the editor without touching anything functional.

return {
  -- Colorscheme. tokyonight is popular, well-maintained, and has a "day"
  -- variant if you prefer light mode.
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load immediately (colorschemes shouldn't lazy-load)
    priority = 1000, -- load before other plugins so there's no flash of default colors
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Icons used by telescope, lualine, and other plugins' file/type glyphs.
  -- Requires a Nerd Font installed in your terminal (see README).
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Statusline: shows mode, git branch, diagnostics, filetype, position.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy", -- load after startup, not needed for the first frame
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
      })
    end,
  },
}
