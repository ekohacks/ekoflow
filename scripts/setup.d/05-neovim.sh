# ============================================================
#  NEOVIM: bespoke Ekohacks config
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

mkdir -p "$NVIM_CONFIG"
mkdir -p "$HOME/.vim/undodir"

cat > "$NVIM_CONFIG/init.lua" << 'NVIM_EOF'
-- ============================================================
--  EKOHACKS NEOVIM CONFIG
--  Debian 13 Trixie Edition
--
--  Minimal. Intentional. No plugins until you earn them.
--
--  Key bindings cheat sheet:
--    <Space>       Leader key
--    <Space>t      Run vitest on current file
--    <Space>ta     Run all tests
--    <Space>tw     Watch tests on current file
--    <Space>e      File explorer (netrw)
--    <Space>v      Vertical split
--    <Space>s      Horizontal split
--    <Space>w      Save
--    <Space>q      Quit
--    <Space>gs     Git status
--    <Space>gd     Git diff
--    <Space>gl     Git log
--    Ctrl+h/j/k/l Navigate between splits
-- ============================================================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================
-- CORE SETTINGS
-- ============================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Status line: minimal, shows what matters
vim.opt.statusline = " %f %m %= [%{&filetype}] %l:%c  %p%% "

-- Colourscheme: built in, no plugin needed
vim.cmd("colorscheme habamax")

-- Netrw settings (file explorer)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- ============================================================
-- KEYMAPS
-- ============================================================
local map = vim.keymap.set

-- File navigation
map("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

-- Window management
map("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>s", ":split<CR>", { desc = "Horizontal split" })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centred when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep search results centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- TDD workflow: run vitest from nvim
map("n", "<leader>t", ":!npx vitest run %<CR>", { desc = "Run tests (file)" })
map("n", "<leader>ta", ":!npx vitest run<CR>", { desc = "Run all tests" })
map("n", "<leader>tw", ":!npx vitest --watch %<CR>", { desc = "Watch tests (file)" })

-- Quick save and quit
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Git shortcuts (quick glance without leaving nvim)
map("n", "<leader>gs", ":!git status<CR>", { desc = "Git status" })
map("n", "<leader>gd", ":!git diff<CR>", { desc = "Git diff" })
map("n", "<leader>gl", ":!git log --oneline -20<CR>", { desc = "Git log" })
map("n", "<leader>gc", ':!git add -A && git commit -v<CR>', { desc = "Git commit" })

-- Paste over selection without losing register
map("x", "<leader>p", '"_dP')

-- ============================================================
-- AUTOCMDS
-- ============================================================

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Wider column for test files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.test.ts", "*.test.js", "*.spec.ts", "*.spec.js" },
  callback = function()
    vim.opt_local.colorcolumn = "120"
  end,
})

-- Return to last edit position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
NVIM_EOF
