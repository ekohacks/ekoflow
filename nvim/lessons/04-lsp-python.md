# Lesson 04 — LSP for Python

## What LSP actually is

Before LSP existed, every editor needed its own custom integration for
every language (VS Code's Python support, Vim's Python support, Emacs's
Python support — all separately written, all separately maintained).

LSP standardizes this: a **language server** (a separate background
process, e.g. `pyright`, written by Microsoft) speaks a fixed JSON-RPC
protocol. Any editor with an LSP *client* — Neovim has one built in — can
talk to any LSP server. Your editor sends "what's at this cursor position?"
and the server replies with type info, definitions, diagnostics, etc.

## Getting the servers installed

Open `lua/plugins/lsp.lua`. Three plugins work together:

1. **mason.nvim** — a package manager *for* language servers/linters/
   formatters (separate from your OS package manager). Run `:Mason` to see
   its UI — a list of installable tools.
2. **mason-lspconfig.nvim** — bridges Mason's naming (`pyright`) to
   nvim-lspconfig's expected setup calls.
3. **nvim-lspconfig** — ships ready-made "how do I start and configure this
   particular server" recipes for hundreds of servers, so you don't hand-
   write the startup command yourself.

## Why two Python servers (pyright + ruff_lsp)?

- **pyright** — type checking, "go to definition", hover docs, rename
  across files. Excellent at understanding Python's type system (including
  type hints common in scientific/bioinformatics codebases using e.g.
  `numpy.typing`).
- **ruff_lsp** — near-instant linting (written in Rust). Catches unused
  imports, style issues, common bugs — much faster than older tools like
  `pylint` or `flake8`.

Running both is standard practice: they don't conflict, they cover
different jobs.

## The `LspAttach` autocommand

Read the `vim.api.nvim_create_autocmd("LspAttach", ...)` block in
`lsp.lua`. This fires once *any* language server successfully attaches to
the file you're editing, and only then binds keymaps like `gd` (go to
definition) and `K` (hover docs) — scoped to that buffer (`{ buffer =
event.buf }`). Open a plain `.txt` file and notice `gd` does nothing there;
open a `.py` file and it works. That's this scoping in action.

## Exercise

1. Open a `.py` file (create a scratch one: `test.py` with
   `import os\n\ndef add(a, b):\n    return a + b\n`).
2. Run `:LspInfo` — confirm `pyright` and `ruff_lsp` both show "attached".
3. Put your cursor on `add` where it's called elsewhere in the file and
   press `gd`. Then press `K` on `os` to see its hover docs.
4. Introduce a deliberate bug (`import sys` but never use it) and save —
   ruff_lsp should flag it. Press `<leader>e` to see the diagnostic detail.

Next: [Lesson 05 — Completion & Snippets](05-completion-and-snippets.md)
