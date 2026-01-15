return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui"] = function()
        dapui.close()
      end

      -- Debug keymaps
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F10>", dap.step_over)
      vim.keymap.set("n", "<F11>", dap.step_into)
      vim.keymap.set("n", "<F12>", dap.step_out)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
    end,
  },
}

