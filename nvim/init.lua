-- ~/.config/nvim/init.lua
--
-- This is the ONLY file Neovim loads automatically on startup. Everything
-- else is pulled in from here, in a deliberate order:
--
--   1. options   -- how the editor behaves (before plugins touch anything)
--   2. keymaps   -- our custom keybindings (leader key must exist first)
--   3. autocmds  -- small automatic behaviors
--   4. lazy      -- the plugin manager, which then loads everything in
--                   lua/plugins/*.lua
--
-- Read these in order the first time — that's the whole editor.

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
