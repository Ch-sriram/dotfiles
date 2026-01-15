return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          layout_config = {
            horizontal = {
              preview_width = 0.6
            }
          }
        }
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Document Symbols" })
      vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
      vim.keymap.set("n", "<leader>ci", builtin.lsp_incoming_calls, { desc = "Incoming Calls" })
      vim.keymap.set("n", "<leader>co", builtin.lsp_outgoing_calls, { desc = "Outgoing Calls" })

    end,
  }
}

