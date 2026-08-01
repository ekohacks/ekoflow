# Lesson 03 — The Plugin Manager (lazy.nvim)

## The bootstrap problem

To install plugins with a plugin manager, you first need... the plugin
manager itself. `lua/config/lazy.lua` solves this with a "bootstrap": if
lazy.nvim isn't already on disk, clone it from GitHub with a raw shell
`git clone` call, *then* load it normally.

Read `lua/config/lazy.lua` top to bottom. The key line at the end is:

```lua
require("lazy").setup("plugins", { ... })
```

Passing the string `"plugins"` (not a table of plugin specs directly) tells
lazy.nvim: "look at every `.lua` file inside `lua/plugins/`, and treat
whatever table each one `return`s as a plugin spec." That's the entire
mechanism connecting `lua/plugins/*.lua` to the running editor — there's no
other registration step.

## Anatomy of a plugin spec

Open `lua/plugins/git.lua` — it's the simplest one. Structurally:

```lua
return {
  "lewis6991/gitsigns.nvim", -- [1] GitHub "user/repo" — where to fetch it from
  event = { ... },            -- [2] WHEN to load it (see below)
  config = function() ... end -- [3] what to run once it's loaded
}
```

### Lazy-loading triggers

This is the actual point of "lazy" in lazy.nvim — plugins don't load at
startup unless they need to. Common triggers you'll see across this repo:

| Key | Meaning | Used in |
|---|---|---|
| `event = "VeryLazy"` | load shortly after startup, non-blocking | `ui.lua` (lualine) |
| `event = { "BufReadPost", "BufNewFile" }` | load when a file is opened | `treesitter.lua`, `git.lua` |
| `cmd = "Telescope"` | load only when that command is run | `telescope.lua` |
| `keys = { ... }` | load only when one of those keys is pressed | `telescope.lua`, `testing.lua` |
| `lazy = false` | never lazy-load, load at startup | `ui.lua` (colorscheme — needs to be active immediately) |

This is why `nvim` starts fast even with a dozen plugins: most of them
haven't actually loaded any code until you do something that needs them.

## Exercise

1. Run `:Lazy` inside Neovim. This opens lazy.nvim's UI — you can see every
   plugin, its load time, and whether it loaded eagerly or lazily.
2. Find `gitsigns.nvim` in that list and note what triggered it to load in
   your current session (open a file first, then check).
3. Add ONE new plugin of your choice as a new file
   `lua/plugins/scratch.lua`, e.g. `"folke/which-key.nvim"` (shows available
   keybindings in a popup — genuinely useful while learning this config).
   Give it `event = "VeryLazy"` and an empty `config = true`. Restart
   Neovim and confirm `:Lazy` shows it installed.

Next: [Lesson 04 — LSP for Python](04-lsp-python.md)
