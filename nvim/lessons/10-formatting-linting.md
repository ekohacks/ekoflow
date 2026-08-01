# Lesson 10 — Formatting & Linting

## Linting vs formatting — a distinction worth being precise about

- **Linting** finds *problems*: unused imports, undefined names, likely
  bugs, style violations that could be actual mistakes. This is `ruff_lsp`
  in `lsp.lua` (lesson 04) — it reports diagnostics you have to actively
  decide how to fix.
- **Formatting** enforces *style consistency*: line length, quote style,
  indentation, trailing commas. There's no "right answer" being computed —
  it's a deterministic rewrite so nobody argues about spacing in code
  review. This is `conform.nvim` in `formatting.lua`.

Both matter, but they're solving different problems, which is why they're
two separate files/plugins in this repo rather than one.

## Reading `formatting.lua`

```lua
formatters_by_ft = {
  python = { "black" },
  javascript = { "prettier" },
  ...
}
```

This maps filetype → list of formatter(s) to run, in order, when
formatting that file. `black` is deliberately near-zero-configuration by
design (a core part of its philosophy) — there's nothing to bikeshed.

```lua
format_on_save = {
  timeout_ms = 1000,
  lsp_fallback = true,
}
```

This is a genuine team decision, not just a technical default:
format-on-save means you literally cannot commit inconsistently-formatted
code (it gets fixed before you even see it), at the cost of every save
potentially changing whitespace you didn't intend to touch. Some teams
prefer this; some prefer explicit `<leader>lf` and reviewing the diff
first. Worth discussing with the team once this config is rolled out
beyond your machine.

## mason-tool-installer

```lua
ensure_installed = { "black", "ruff", "prettier" }
```

This is a separate installer from the LSP servers in lesson 04 — these are
standalone CLI binaries (not language servers), but still managed by the
same underlying `mason.nvim` registry, so you don't need three different
installation methods for three different tools.

## Exercise

1. Deliberately write a badly-formatted Python function (inconsistent
   quotes, weird spacing, no blank lines) and save it. Confirm `black`
   reformats it automatically.
2. Temporarily comment out `format_on_save` in `formatting.lua`, restart
   Neovim, repeat the messy-code test, and confirm nothing happens
   automatically — then manually run `<leader>lf` and confirm it now
   formats on demand. Uncomment `format_on_save` again afterward.
3. Open a discussion (with me or the team) on whether EkoHacks wants
   format-on-save enabled by default in the shared config, or opt-in via
   `<leader>lf` — write down the outcome as a comment at the top of
   `formatting.lua`.

Next: [Lesson 11 — Daily Workflow & What's Next](11-daily-workflow.md)
