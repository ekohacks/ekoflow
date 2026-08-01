-- lua/plugins/telescope.lua
--
-- Telescope: fuzzy finder for files, text, buffers, help, git status, and
-- more. This replaces the workflow of "open a file tree and click around" —
-- instead you fuzzy-search by name/content and jump straight there.
--
-- Requires the external tools `ripgrep` (live_grep) and `fd` (fast find_files)
-- — see README installation steps.

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim", -- utility library many plugins depend on
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- native sort algorithm, much faster on large repos
    },
  },
  cmd = "Telescope", -- lazy-load: only load when a :Telescope command is run
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep across project" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help docs" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened files" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "__pycache__/", "%.venv/", "node_modules/" },
      },
    })
    pcall(telescope.load_extension, "fzf")
  end,
}
