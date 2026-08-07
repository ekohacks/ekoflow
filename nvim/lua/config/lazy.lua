-- lua/config/lazy.lua
--
-- Bootstraps `lazy.nvim`, the plugin manager. This is the ONLY plugin we
-- install "manually" — every other plugin is declared as data (a Lua table)
-- and lazy.nvim reads/installs/loads it for us.
--
-- Why lazy.nvim specifically? It lazy-loads plugins (only loads code when
-- actually needed — e.g. on a filetype or keypress), which keeps startup
-- fast even as we add more capability. It's also the standard the wider
-- Neovim community has converged on, so docs/help are easy to find.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- First run: lazy.nvim doesn't exist yet, so clone it from GitHub.
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Every file in lua/plugins/ that returns a plugin spec table gets picked
-- up automatically by pointing lazy.setup() at the "plugins" module name.
-- This is why plugins/lsp.lua, plugins/ui.lua, etc. each `return { ... }`.
require("lazy").setup("plugins", {
  install = { colorscheme = { "habamax" } }, -- fallback theme while ui.lua's theme installs
  checker = { enabled = false }, -- don't auto-check for plugin updates in background
  change_detection = { notify = false }, -- don't pop up a notification on config file changes
})
