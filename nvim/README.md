# ekohacks-nvim

A bespoke Neovim editor, built from a minimal skeleton and extended piece by
piece — written for the EkoHacks team, optimized for Python (including
bioinformatics work), and designed as a teaching tool for a junior dev
learning Lua and how editors are actually built.

This is **not** a drop-in distribution like LazyVim. It's intentionally small
and fully readable — every file is short enough to read top to bottom and
understand exactly what it does. The goal is that by the time you've gone
through `lessons/`, you understand every line of your own editor.

## Philosophy

- **Skeleton first, extend deliberately.** We start with almost nothing
  (options + keymaps), get `lazy.nvim` running, then add one capability
  (LSP, completion, testing, git, formatting) at a time.
- **Every plugin earns its place.** No kitchen-sink config. If a plugin is
  here, there's a lesson explaining why we picked it and what it replaces
  from "plain Vim."
- **Python + bioinformatics first**, since that's EkoHacks' current
  priority stack — but the structure generalizes to any language.

## Structure

```
init.lua                  -- entry point, just requires the pieces below
lua/config/
  options.lua              -- vim.opt settings (the "vimrc" part)
  keymaps.lua              -- leader key + custom keybindings
  autocmds.lua             -- small quality-of-life automations
  lazy.lua                 -- bootstraps the lazy.nvim plugin manager
lua/plugins/
  ui.lua                   -- colorscheme, statusline, icons
  telescope.lua            -- fuzzy finder (files, grep, buffers)
  treesitter.lua           -- syntax-aware highlighting & parsing
  lsp.lua                  -- language server protocol (Python-first)
  completion.lua           -- autocomplete engine + snippets
  formatting.lua           -- auto-format & lint on save
  testing.lua              -- run tests from inside the editor (TDD workflow)
  git.lua                  -- inline git status, hunks, blame
lessons/
  00-overview.md ... 11-daily-workflow.md   -- the teaching series
```

## Installation (Windows)

1. Install Neovim: `winget install Neovim.Neovim`
2. Install prerequisites:
   ```powershell
   winget install Git.Git
   winget install BurntSushi.ripgrep.MSVC
   winget install sharkdp.fd
   winget install --id OpenJS.NodeJS.LTS
   winget install Python.Python.3.12
   ```
3. Install a [Nerd Font](https://www.nerdfonts.com/) (e.g. JetBrainsMono Nerd
   Font) and set it as your terminal's font.
4. Back up any existing config, then copy this repo's contents into
   `%localappdata%\nvim`:
   ```powershell
   Rename-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -ErrorAction SilentlyContinue
   git clone <this-repo-url> $env:LOCALAPPDATA\nvim
   ```
5. Launch `nvim`. On first run, `lazy.nvim` bootstraps itself and installs
   every plugin automatically. Then run `:Mason` once to confirm Python
   language servers/formatters installed correctly (see lesson 04).

## Start here

Open [`lessons/00-overview.md`](lessons/00-overview.md) and work through the
series in order. Each lesson tells you which file(s) to open alongside it.
