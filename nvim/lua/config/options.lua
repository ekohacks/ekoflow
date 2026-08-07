-- lua/config/options.lua
--
-- This is the Lua equivalent of a classic `.vimrc`. Every `vim.opt.X = Y`
-- line sets one editor option. Nothing here depends on any plugin — this
-- would still work in stock Neovim with no plugins installed at all.
--
-- Docs for any option: `:help 'optionname'` (with the quotes), e.g. `:help 'number'`

local opt = vim.opt

-- Leader key must be set before any keymaps that use <leader> (see keymaps.lua)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Line numbers ─────────────────────────────────────────────────────────
opt.number = true -- show absolute line number on the current line
opt.relativenumber = true -- and relative numbers on every other line (fast jumps: 5j, 3k)

-- ── Indentation ──────────────────────────────────────────────────────────
-- Python (PEP8) and JS/TS conventionally use 4 and 2 spaces respectively.
-- We set a sane default here; treesitter + per-filetype autocmds can override.
opt.tabstop = 4 -- how many columns a <Tab> character visually occupies
opt.shiftwidth = 4 -- how many columns to indent with << / >> / autoindent
opt.expandtab = true -- pressing <Tab> inserts spaces, not a literal tab char
opt.smartindent = true -- reasonable auto-indent on new lines

-- ── Search ───────────────────────────────────────────────────────────────
opt.ignorecase = true -- case-insensitive search...
opt.smartcase = true -- ...unless the search term has an uppercase letter
opt.incsearch = true -- show matches as you type
opt.hlsearch = true -- highlight all matches (cleared with <leader>nh, see keymaps.lua)

-- ── UI ───────────────────────────────────────────────────────────────────
opt.termguicolors = true -- true color support (needed for nice colorschemes)
opt.signcolumn = "yes" -- always reserve space for git/diagnostic signs (no layout shift)
opt.cursorline = true -- highlight the line the cursor is on
opt.scrolloff = 8 -- keep 8 lines visible above/below cursor when scrolling
opt.wrap = false -- don't soft-wrap long lines
opt.splitright = true -- vertical splits open to the right
opt.splitbelow = true -- horizontal splits open below

-- ── Files & backups ──────────────────────────────────────────────────────
opt.swapfile = false -- no .swp files cluttering the project
opt.backup = false
opt.undofile = true -- persistent undo history across sessions (survives closing nvim)
opt.updatetime = 250 -- faster completion/diagnostic UI updates (default is 4000ms)

-- ── Completion behavior ──────────────────────────────────────────────────
opt.completeopt = { "menuone", "noselect" } -- required by nvim-cmp (see plugins/completion.lua)

-- ── Clipboard ────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus" -- yank/paste use the system clipboard by default
