# Lesson 06 — Treesitter

## The problem with regex-based highlighting

Classic Vim syntax highlighting uses regex patterns per filetype. Regex
doesn't understand nesting or context — it's easy to trick with, say, a
string containing something that looks like a keyword. It's also slow to
extend for new language features.

Treesitter instead parses your file into a real **syntax tree** (the same
kind of structure a compiler builds), incrementally, on every keystroke,
fast enough to feel instant. Every plugin that needs to understand code
structure — highlighting, indentation, our test runner in lesson 09 — can
query that tree instead of re-inventing parsing.

## Reading `treesitter.lua`

```lua
ensure_installed = { "python", "lua", "markdown", ... }
```

Each of these downloads and compiles a small parser (written in C,
generated from a grammar) specific to that language. `auto_install = true`
means if you open a filetype not in this list, treesitter fetches its
parser on the spot rather than failing silently.

```lua
highlight = { enable = true }
indent = { enable = true }
```

Two independent features built on the same parse tree: highlighting colors
tokens by their actual syntactic role (a function *call* vs a function
*definition* can be colored differently); indent uses tree structure to
decide how to indent a new line, more reliably than regex-based
`smartindent` (which we still keep in `options.lua` as a fallback for
filetypes without a treesitter indent module).

## Try seeing the tree yourself

1. Open any Python file.
2. Run `:InspectTree` (a command treesitter ships with the plugin).
3. A split opens showing the live syntax tree of your file. Move your
   cursor in the code buffer and watch the corresponding tree node
   highlight in the tree view — this is exactly what plugins "see" when
   they query your code.

## Exercise

1. Run `:InspectTree` on a Python file with a function containing a nested
   `if` inside a `for` loop. Identify the tree nodes for the `for`, the
   `if`, and the function body in the tree view.
2. In `treesitter.lua`, add `"dockerfile"` and `"toml"` to
   `ensure_installed` (EkoHacks projects likely have Dockerfiles and
   `pyproject.toml` files). Restart Neovim, open a Dockerfile, confirm
   highlighting now applies (there was none before, since it wasn't
   parsed).

Next: [Lesson 07 — Telescope](07-telescope-fuzzy-finding.md)
