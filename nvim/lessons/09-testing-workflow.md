# Lesson 09 — Testing / TDD Workflow

## Why this matters at EkoHacks specifically

TDD (write a failing test, then the minimum code to pass it, then refactor)
only feels good when the test-run feedback loop is fast and doesn't yank
you out of the editor into a terminal every time. `neotest` closes that
loop: run a single test under your cursor, see pass/fail inline, keep
typing.

## Reading `testing.lua`

```lua
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      runner = "pytest",
    }),
  },
})
```

Neotest itself is language-agnostic — it defines a common UI and set of
commands (`run`, `summary`, `output`). `neotest-python` is the **adapter**
that knows how to discover pytest tests in a Python project and translate
neotest's generic "run this test" into an actual `pytest` invocation.

If EkoHacks later adds a JS/TS test suite (Jest/Vitest), that would be a
second adapter (`neotest-jest` or a Vitest equivalent) added to this same
`adapters` table — the rest of the plugin, including all four keymaps,
would work identically for both languages with zero extra config.

## The keymaps

| Keymap | Action |
|---|---|
| `<leader>tr` | Run the nearest test (wherever your cursor is) |
| `<leader>tf` | Run every test in the current file |
| `<leader>ts` | Toggle a summary panel (tree view of all discovered tests, pass/fail state) |
| `<leader>to` | Open full output of the last run test (stdout/stderr, tracebacks) |

## A real TDD loop, start to finish

1. Write a test function for something that doesn't exist yet:
   ```python
   def test_gc_content():
       assert gc_content("GCGC") == 1.0
   ```
2. Put your cursor inside it, press `<leader>tr` — it fails (function
   doesn't exist yet). Press `<leader>to` to see the actual error.
3. Implement `gc_content` in the source file.
4. Press `<leader>tr` again from the test — confirm it passes.
5. Stage just this change with gitsigns (`<leader>hs`, lesson 08) or a
   normal `git add`, and commit.

## Exercise

1. Do the loop above for real, with a genuinely new small function (e.g.
   a simple bioinformatics utility like reverse-complementing a DNA
   string).
2. Open `<leader>ts` (summary panel) with at least 3 tests in a file —
   some passing, some failing on purpose — and confirm the tree view
   accurately reflects each one's state.
3. Research (don't just copy) how you'd add a JS/TS adapter (e.g.
   `nvim-neotest/neotest-jest` or a Vitest adapter) to this same
   `adapters` table for a future EkoHacks frontend repo, and write a
   short note in this file (or a PR comment) describing the two lines
   you'd add and why.

Next: [Lesson 10 — Formatting & Linting](10-formatting-linting.md)
