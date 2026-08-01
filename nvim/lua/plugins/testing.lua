-- lua/plugins/testing.lua
--
-- EkoHacks practices TDD, so running tests without leaving the editor
-- matters a lot for flow. neotest gives a unified test runner UI across
-- languages; neotest-python is the Python adapter (pytest/unittest aware).
--
-- Workflow this enables: write a failing test -> <leader>tr to run just
-- that test -> see pass/fail inline -> implement -> re-run -> repeat.

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
  },
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run all tests in file",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary panel",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Show test output",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          -- Assumes pytest; auto-detects a virtualenv if one is active.
          runner = "pytest",
        }),
      },
    })
  end,
}
