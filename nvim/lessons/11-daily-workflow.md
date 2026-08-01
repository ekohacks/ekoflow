# Lesson 11 — Daily Workflow & What's Next

## Putting it all together: a realistic EkoHacks session

1. `nvim` from a project root.
2. `<leader>ff` — find the file you're working on today.
3. `<leader>fg` — grep for a function/class you need to modify.
4. Write a failing test → `<leader>tr` to confirm it fails →
   implement → `<leader>tr` again to confirm it passes (lesson 09).
5. `<leader>lf` (or let format-on-save handle it, lesson 10) to keep style
   consistent.
6. Check `]h` / `[h` and `<leader>hp` to review your actual diff hunk by
   hunk before staging (lesson 08).
7. `<leader>hs` to stage each reviewed hunk, then commit from a terminal
   (or `:!git commit`).
8. `gd` / `gr` / `K` (lesson 04) whenever you need to jump to or understand
   a definition without breaking flow to open a browser/docs.

Every keymap above was something you read, understood, and could have
written yourself by this point — that's the actual point of this exercise.

## Full keymap reference

| Keymap | Action | Lesson |
|---|---|---|
| `<leader>ff` / `fg` / `fb` / `fh` / `fo` | Telescope pickers | 07 |
| `gd` / `gr` / `K` / `<leader>rn` / `<leader>ca` | LSP navigation & actions | 04 |
| `[d` / `]d` / `<leader>e` | Diagnostics | 04 |
| `<leader>lf` | Format buffer | 10 |
| `<leader>tr` / `tf` / `ts` / `to` | Run tests | 09 |
| `]h` / `[h` / `<leader>hs` / `hr` / `hp` / `hb` | Git hunks | 08 |
| `<leader>w` / `q` | Save / quit | 02 |
| `<leader>sv` / `sh` / `se` / `sx` | Window splits | 02 |
| `<C-h/j/k/l>` | Move between windows | 02 |

## What to build next (stretch goals)

These are deliberately left undone so you have real, non-trivial follow-up
work once this series is finished:

1. **Bioinformatics notebooks** — investigate `molten.nvim` or
   `jupytext.vim` for running Jupyter-style cells inside Neovim, since
   EkoHacks' genomics/bioinformatics work likely involves notebook-style
   exploration. This has real dependency complexity (image rendering,
   kernel management) — a good multi-day project once you're comfortable
   with everything above.
2. **which-key.nvim** — shows a popup of available keybindings as you type
   `<leader>`, so you (and future teammates) don't need to memorize this
   table. Good first "real" plugin addition, low risk.
3. **DAP (Debug Adapter Protocol)** — step-through debugging inside Neovim
   (`nvim-dap` + `nvim-dap-python`), for when print-statement debugging
   isn't enough.
4. **Project-local config** — investigate `.nvim.lua` / `exrc` patterns so
   different EkoHacks repos (Python backend vs. TypeScript/React frontend)
   can each tune formatter/linter behavior without touching this shared
   base config.
5. **Share it back** — once you've extended this for a few weeks, do a
   short walkthrough for the next junior dev who joins. Teaching it is the
   best way to confirm you actually understand it.

You now own this editor. Anything that annoys you about your daily
workflow is fixable in a `.lua` file you can read end to end — that's the
whole point of building it this way instead of installing someone else's
500-plugin distribution.
