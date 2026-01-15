return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "-" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
      })

      -- Git keymaps
      vim.keymap.set("n", "]c", require("gitsigns").next_hunk)
      vim.keymap.set("n", "[c", require("gitsigns").prev_hunk)
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk)
      vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk)
    end,
  },
}

