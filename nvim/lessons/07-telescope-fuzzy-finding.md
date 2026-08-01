# Lesson 07 — Telescope (Fuzzy Finding)

## The core idea: pickers + fuzzy matching

Telescope's model is simple: a **picker** produces a list of things (files
on disk, lines matching a grep, open buffers, help tags, git commits...),
you type a few fuzzy characters, and it filters/ranks the list live. Enter
jumps you straight to the selected item.

This replaces the "open a file tree sidebar, visually scan, click" loop
with "type 3-4 characters of a filename you remember, hit enter."

## The keymaps

From `lua/plugins/telescope.lua`:

| Keymap | Picker | Use it for |
|---|---|---|
| `<leader>ff` | `find_files` | jump to a file by (partial, fuzzy) name |
| `<leader>fg` | `live_grep` | search file *contents* across the whole project (needs ripgrep) |
| `<leader>fb` | `buffers` | jump between files already open |
| `<leader>fh` | `help_tags` | search Neovim's built-in help docs |
| `<leader>fo` | `oldfiles` | recently opened files, even from previous sessions |

`live_grep` is the one that will save you the most time day to day — it's
effectively "search this entire codebase for this string/pattern" without
leaving the editor or spawning a separate terminal `grep` command.

## Why `file_ignore_patterns` matters

```lua
file_ignore_patterns = { "%.git/", "__pycache__/", "%.venv/", "node_modules/" }
```

Without this, `find_files` and `live_grep` would surface thousands of
irrelevant matches from dependency/cache folders, making fuzzy search
nearly useless on any real project. Note the Lua pattern syntax: `%.`
escapes the literal dot (in Lua patterns, `.` alone means "any character",
same idea as regex).

## Exercise

1. In an EkoHacks repo (or any repo with more than a few files), try
   `<leader>ff` and find a file by typing just 3-4 non-contiguous letters
   of its name — notice it still matches (that's the "fuzzy" part, not
   substring matching).
2. Try `<leader>fg` and search for a function name you know exists
   somewhere in the codebase. Press Enter on a result and confirm your
   cursor lands exactly on that line.
3. Add a new custom picker keymap, `<leader>fc`, bound to
   `git_commits` (search git log fuzzy). Look up the exact Telescope
   builtin name in `:help telescope.builtin` first, then wire it into
   `telescope.lua`'s `keys` table.

Next: [Lesson 08 — Git Integration](08-git-integration.md)
