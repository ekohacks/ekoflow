# Lesson 00 — Overview & Setup

## Why build an editor instead of just using one?

Anyone can install VS Code. Building your own Neovim config teaches you:
- How a text editor is actually structured under the hood
- Enough Lua to script your own tools later (Neovim, Hammerspoon, love2d, etc.)
- How LSPs, formatters, linters, and test runners plug into your daily workflow —
  the same integration points a company's internal tooling often needs

By the end of this series you'll have a working, fast, fully-understood
Python-first editor, and the skills to keep extending it for whatever
EkoHacks needs next (bioinformatics notebooks, TypeScript/React tooling, etc.).

## Prerequisites

Before lesson 01, make sure you have (see the repo `README.md` for exact
install commands):
- Neovim (`nvim --version` works in a terminal)
- git
- ripgrep and fd
- Node.js
- Python 3
- A Nerd Font set in your terminal

## How this series works

Each lesson:
1. Explains a concept
2. Points you at the exact file(s) implementing it in this repo
3. Gives you a small exercise to do yourself

Go in order — lesson 03 (the plugin manager) has to come before anything
that depends on a plugin.

## The lesson map

| # | Topic | File(s) |
|---|---|---|
| 01 | Lua basics + how `init.lua` loads everything | `init.lua` |
| 02 | Options & keymaps | `lua/config/options.lua`, `lua/config/keymaps.lua` |
| 03 | The plugin manager (lazy.nvim) | `lua/config/lazy.lua` |
| 04 | LSP for Python | `lua/plugins/lsp.lua` |
| 05 | Completion & snippets | `lua/plugins/completion.lua` |
| 06 | Treesitter | `lua/plugins/treesitter.lua` |
| 07 | Telescope (fuzzy finding) | `lua/plugins/telescope.lua` |
| 08 | Git integration | `lua/plugins/git.lua` |
| 09 | Testing / TDD workflow | `lua/plugins/testing.lua` |
| 10 | Formatting & linting | `lua/plugins/formatting.lua` |
| 11 | Daily workflow + what to build next | — |

Open lesson 01 when ready.
