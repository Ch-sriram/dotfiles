return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- ensure plugin loads
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "java",
          "lua",
          "json",
          "yaml",
          "bash",
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

