# Lesson 08 — Git Integration

## What gitsigns actually watches

Gitsigns runs `git diff` against your working tree in the background and
annotates each line in the sign column (the narrow strip left of line
numbers) with `+` (added), `~` (changed), or `_` (deleted since this
point). This is the same information `git diff` in a terminal gives you,
but inline, live, as you type — you always know exactly what you've
changed relative to the last commit without switching windows.

## Reading `git.lua`

```lua
on_attach = function(bufnr)
  ...
  map("n", "]h", gs.next_hunk, "Next git hunk")
  map("n", "[h", gs.prev_hunk, "Previous git hunk")
  map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
  map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
  map("n", "<leader>hp", gs.preview_hunk, "Preview hunk diff")
  map("n", "<leader>hb", gs.toggle_current_line_blame, "Toggle line blame")
end,
```

A "hunk" is a contiguous block of changed lines — the same unit `git add
-p` (interactive staging) works with. `<leader>hs` lets you stage just
that hunk, without needing to leave the editor or run `git add -p` in a
terminal. This matters a lot in TDD-style workflows: you can stage exactly
the change you just made and verified, one small hunk at a time, keeping
commits atomic.

`toggle_current_line_blame` shows, inline, who last touched the current
line and when — same information as `git blame` but contextual and
toggle-able rather than a separate full-file view.

## Exercise

1. Make a small edit to any file already tracked in git, save it, and
   confirm the `~` sign appears next to the changed line.
2. Put your cursor on that line and run `<leader>hp` — confirm a diff
   preview popup shows exactly what changed.
3. Run `<leader>hs` to stage just that hunk, then confirm with a terminal
   `git diff --staged` that only that hunk is staged (not the whole file,
   if you made multiple unrelated changes).
4. Toggle `<leader>hb` on a file with real git history and read the blame
   info for a line you didn't write.

Next: [Lesson 09 — Testing / TDD Workflow](09-testing-workflow.md)
