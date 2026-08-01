# Lesson 02 — Options & Keymaps

## Options: `vim.opt`

Open `lua/config/options.lua`. Every line follows the pattern:

```lua
opt.someoption = somevalue
```

This is Lua sugar for the classic Vimscript `:set someoption=somevalue`.
Some options take booleans (`true`/`false`), some take numbers, some take
strings, and a few (like `completeopt`) take a Lua table that gets joined
into a comma list behind the scenes.

Try this live experiment:
1. Open `nvim`, then run `:set number?` — it prints the current value.
2. Run `:set number!` — this *toggles* it.
3. Now you understand why `options.lua` sets it permanently instead of you
   typing this every session.

## Keymaps: `vim.keymap.set`

Open `lua/config/keymaps.lua`. The shape is always:

```lua
vim.keymap.set(mode, lhs, rhs, opts)
```

- `mode` — a string like `"n"` (normal mode), `"i"` (insert), `"v"` (visual).
  You can also pass a table of modes: `{ "n", "v" }`.
- `lhs` — the key sequence you type, e.g. `"<leader>w"`. `<leader>` is a
  placeholder that expands to whatever `vim.g.mapleader` is set to (we set
  it to the spacebar in `options.lua`).
- `rhs` — what happens: either a command string (`":w<CR>"`) or a Lua
  function.
- `opts` — a table, almost always at least `{ desc = "..." }` so the
  keybinding is self-documenting (shows up in which-key style plugins/help).

## Why keymaps live in three different files

Notice: general keymaps are in `lua/config/keymaps.lua`, but Telescope's
keymaps are in `lua/plugins/telescope.lua`, and LSP's keymaps are inside
`lua/plugins/lsp.lua`'s `LspAttach` autocommand. This is intentional:

- **Config-level keymaps** (save, quit, window splits) work with zero
  plugins installed — they belong in `config/`.
- **Plugin-specific keymaps** only make sense once that plugin is loaded,
  so they live right next to that plugin's setup. If you ever remove a
  plugin, its keymaps disappear with it automatically — nothing orphaned.

## Exercise

1. Add a new keymap to `lua/config/keymaps.lua` that maps `<leader>x` to
   close the current buffer without closing the window (`:bd<CR>`... but
   look up whether that's really the safest command, or if there's a
   plugin-free alternative — this is intentionally a small research task).
2. Change `<leader>nh` to something else you find more comfortable, and
   explain in one sentence why keymap *muscle memory* is a real cost when
   changing defaults later on a shared team config.

Next: [Lesson 03 — The Plugin Manager](03-plugin-manager-lazynvim.md)
