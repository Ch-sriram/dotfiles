return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Global LSP keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      vim.keymap.set("n", "K",  vim.lsp.buf.hover, { desc = "Hover on Code" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>th", vim.lsp.buf.type_definition, { desc = "Type Definition" })
      vim.keymap.set("n", "<leader>ch", vim.lsp.buf.incoming_calls, { desc = "Call Hierarchy (Incoming)" })

      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(
           not vim.lsp.inlay_hint.is_enabled()
        )
      end, { desc = "Toggle Inlay Hints" })
    end,
  },
}

