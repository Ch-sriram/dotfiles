return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = "open_default",
        },
        window = {
          position = "left",
          width = 30,
        },
      })

      -- Toggle Neo-tree (show/hide)
      vim.keymap.set("n", "<leader>e", function()
        vim.cmd("Neotree toggle")
      end, { desc = "Toggle Neo-tree" })

      -- Focus Neo-tree (jump to it if open)
      vim.keymap.set("n", "<leader>o", function()
        vim.cmd("Neotree focus")
      end, { desc = "Focus Neo-tree" })
    end,
  },
}

