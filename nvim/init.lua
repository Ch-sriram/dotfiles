-- Set leader key early
vim.g.mapleader = " "

-- Bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Java LSP autostart
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("lsp.java").setup()
  end,
})

-- =========================
-- LSP Diagnostics
-- =========================

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- could be ■, ●, ▎
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- =========================
-- Java build commands
-- =========================

-- Register the command :JavaNew
vim.api.nvim_create_user_command("JavaNew", function()
  require("utils.java_new").create_java_class()
end, {})

vim.api.nvim_create_user_command("MvnBuild", function()
  vim.cmd("AsyncRun mvn test")
end, {})

vim.api.nvim_create_user_command("MvnCompile", function()
  vim.cmd("AsyncRun mvn compile")
end, {})

vim.api.nvim_create_user_command("GradleBuild", function()
  vim.cmd("AsyncRun gradle build")
end, {})

-- =========================
-- Java Related Keymaps
-- =========================
vim.keymap.set("n", "<leader>n", ":JavaNew<CR>", { desc = "Create New Java Class" })


-- =========================
-- Line number configuration
-- =========================

-- Enable line numbers by default
vim.opt.number = true

-- Disable relative numbers in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- Enable relative numbers when NOT in insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- =========================
-- Cursor line highlighting
-- =========================

-- Highlight the current line
vim.opt.cursorline = true

-- =========================
-- Column rulers
-- =========================

-- Show vertical lines at these columns
-- vim.opt.colorcolumn = "80,100"

-- =========================
-- Clipboard settings
-- =========================
vim.opt.clipboard = "unnamedplus"

