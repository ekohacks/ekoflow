# Lesson 01 — Lua Basics & `init.lua`

## Just enough Lua

You don't need to be a Lua expert to build this — you need these five things:

```lua
-- 1. Variables (no type declarations needed)
local x = 10
local name = "ekohacks"

-- 2. Tables — Lua's one and only data structure (array AND dict/object)
local list = { "a", "b", "c" }         -- array-like
local dict = { key = "value", x = 1 }  -- dict-like
local mixed = { "a", key = "value" }   -- both at once, totally legal

-- 3. Functions (first-class — can be stored in variables, passed around)
local function greet(name)
  print("hi " .. name) -- .. concatenates strings
end

-- 4. Modules — every .lua file IS a module. `require("config.options")`
--    loads lua/config/options.lua (dots = folder separators)
require("config.options")

-- 5. Conditionals & loops (rarely need these in editor config, but here for reference)
if x > 5 then
  print("big")
else
  print("small")
end
```

That's genuinely most of what you need. Everything in this repo is built
from those five pieces plus calling functions that plugins/Neovim expose.

## Reading `init.lua`

Open `init.lua` in the repo root. It's four lines of actual code:

```lua
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
```

`require("config.options")` tells Lua: "look for a module named `options`
inside a folder named `config`, somewhere on the runtime path." Neovim
automatically adds `lua/` in your config directory to that path — so this
resolves to `lua/config/options.lua`.

**Order matters here.** `options.lua` sets `vim.g.mapleader` before
`keymaps.lua` defines any `<leader>`-based keybinding — if you reversed
these two `require` calls, your leader keymaps would silently fail to bind
correctly the first time (try it and see, then put it back!).

## Exercise

1. Add a fifth line to `init.lua`: `print("EkoHacks editor loaded!")`
2. Launch `nvim` and confirm you see the message flash briefly at startup.
3. Remove it once you've confirmed it — we don't want console noise on
   every startup going forward.
4. In `lua/config/options.lua`, find one option you don't understand, run
   `:help 'thatoption'` inside Neovim (replace with the real name, keep the
   quotes) and read the doc. Explain it back in one sentence — to yourself
   or in a PR comment when we review this together.

Next: [Lesson 02 — Options & Keymaps](02-options-and-keymaps.md)
