-- lua/config/keymaps.lua
--
-- Custom keybindings that don't belong to any specific plugin. Plugin-specific
-- keymaps live next to that plugin's config (e.g. Telescope keymaps live in
-- plugins/telescope.lua) so you always know where to look.
--
-- vim.keymap.set(mode, lhs, rhs, opts)
--   mode: "n" normal, "i" insert, "v" visual, "x" visual block, "t" terminal
--   lhs:  the key sequence you press
--   rhs:  what it does (a command string, or a Lua function)
--   opts: table, e.g. { desc = "..." } shows up in which-key style pickers

local keymap = vim.keymap.set

-- Clear search highlight after a search (see opt.hlsearch in options.lua)
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

-- Faster window navigation (instead of <C-w>h/j/k/l)
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move selected lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when jumping half-pages or between search results
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Quick save/quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit window" })

-- Split management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
