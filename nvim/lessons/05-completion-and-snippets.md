# Lesson 05 — Completion & Snippets

## LSP gives suggestions, nvim-cmp shows them

An important distinction: the language server (lesson 04) can *tell* your
editor what completions are valid at the cursor, but it doesn't draw any
UI. `nvim-cmp` is the plugin that renders the popup menu, merges results
from multiple sources, and handles the keys you press to select/confirm.

Open `lua/plugins/completion.lua`. The `sources` table is the important
part:

```lua
sources = cmp.config.sources({
  { name = "nvim_lsp" },
  { name = "luasnip" },
}, {
  { name = "buffer" },
  { name = "path" },
})
```

The two-group structure matters: items in the first group are always
ranked above the second group, regardless of fuzzy-match score. So an LSP
suggestion for a real function name will always outrank a random word from
elsewhere in the buffer, even if the buffer word matches your typed
characters slightly better.

## Snippets

LuaSnip is the snippet engine — it expands short triggers into whole code
blocks with tab-stops you can jump between. `cmp_luasnip` is the glue that
lets nvim-cmp show snippets as completion candidates.

We haven't defined any custom EkoHacks-specific snippets yet — this is a
great first real contribution for you to make. Example: a pytest test
skeleton, or a common bioinformatics script header (imports + argparse
boilerplate).

## Reading the `<Tab>` mapping

This is the trickiest bit of Lua in the whole repo — worth slowing down on:

```lua
["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end, { "i", "s" }),
```

This is a function, not a static action, because `<Tab>` needs to do three
different things depending on context:
1. If the completion menu is open → move to the next item.
2. Else if you're inside a snippet with more tab-stops to jump to → jump.
3. Else → `fallback()`, meaning "do whatever `<Tab>` would normally do"
   (insert an actual tab character/indent).

## Exercise

1. Create a custom Python snippet: a pytest test function skeleton that
   expands from typing `deftest` + Tab. (Look up LuaSnip's `s()` and `i()`
   snippet-node API — this is a good first real Lua research task, not
   something to copy-paste blindly.)
2. Add it in a new file `lua/snippets/python.lua` and `require` it
   somewhere sensible in `completion.lua`'s `config` function.
3. Test it: open a `.py` file, type `deftest`, press Tab, confirm it
   expands and you can Tab between the function name and body placeholders.

Next: [Lesson 06 — Treesitter](06-treesitter.md)
