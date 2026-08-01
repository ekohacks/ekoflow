-- lua/plugins/completion.lua
--
-- nvim-cmp is the autocomplete engine. It doesn't know anything about any
-- language itself — it just merges suggestions from "sources" (plugins)
-- into one popup menu. We wire up: LSP suggestions, snippet expansion,
-- current-buffer words, and file paths.

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- only load once you actually start typing
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- source: suggestions from the active language server
    "hrsh7th/cmp-buffer",   -- source: words already in the current buffer
    "hrsh7th/cmp-path",     -- source: filesystem paths
    "L3MON4D3/LuaSnip",     -- snippet engine (expands e.g. "for" -> a full for-loop)
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),      -- manually trigger completion
        ["<C-e>"] = cmp.mapping.abort(),              -- close the completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept selected suggestion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Order matters: earlier sources rank higher when scores tie.
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
