-- lua/config/autocmds.lua
--
-- Autocommands: "when X event happens, run this Lua function." These are
-- small, focused automations — nothing plugin-heavy, just editor hygiene.
--
-- vim.api.nvim_create_autocmd(event, opts)

local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight yanked (copied) text, so you can see exactly what you grabbed
autocmd("TextYankPost", {
  desc = "Highlight yanked text briefly",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Trim trailing whitespace on save — keeps diffs clean in git
autocmd("BufWritePre", {
  desc = "Trim trailing whitespace before saving",
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Remember cursor position: reopen a file where you left off
autocmd("BufReadPost", {
  desc = "Restore cursor position on file open",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Python files: EkoHacks follows PEP8, so force 4-space indent explicitly
-- even though options.lua already defaults to 4 — this makes the intent
-- explicit and filetype-scoped, which matters once other languages (e.g.
-- JS/TS at 2 spaces) get added later.
autocmd("FileType", {
  desc = "Python indentation (PEP8)",
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})
