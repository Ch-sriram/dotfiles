return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noselect",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),   -- manual trigger
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Esc>"] = cmp.mapping.abort(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },  -- Java LSP (jdtls)
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

