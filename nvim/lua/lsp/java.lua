local M = {}

function M.setup()
  local jdtls = require("jdtls")

  -- 1. Find root
  local root_markers = { 
    "gradlew",
    "mvnw",
    --"pom.xml",
    --"build.gradle",
    ".git"
  }
  local root_dir = require("jdtls.setup").find_root(root_markers)

  if root_dir == nil then return end

  -- 2. Setup paths
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  vim.fn.mkdir(workspace_dir, "p")
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local java21 = "/usr/lib/jvm/java-21-openjdk-amd64/bin/java"
  local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local config_dir = mason_path .. "/config_linux"

  -- 3. Add Capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok_cmp then
    capabilities = cmp_lsp.default_capabilities()
  end

  -- 4. Define Config
  local config = {
    cmd = {
      java21,
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher_jar,
      "-configuration", config_dir,
      "-data", workspace_dir,
    },
    root_dir = root_dir,
    capabilities = capabilities,
    init_options = {
      extendedClientCapabilities = extendedClientCapabilities,
      bundles = {}, -- Explicitly set empty bundles to avoid confusion
    },
    on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap=true, silent=true }
      -- Java specific keymaps
      -- Organize Imports (The most important one!)
      buf_set_keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)

      -- Extract variable (Visual mode)
      buf_set_keymap("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)

      -- Extract method (Visual mode)
      buf_set_keymap("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
    end,
    settings = {
      java = {
        eclipse = { downloadSources = true },
        configuration = { updateBuildConfiguration = "interactive" },
        maven = { downloadSources = true },
        references = { includeDecompiledSources = true },
        inlayHints = { parameterNames = { enabled = "all" } },
        format = {
	  enabled = true,
	  settings = {
            url = "file://" .. vim.fn.stdpath("config") .. "/eclipse-java-google-style.xml",
	    profile = "GoogleStyle",
	  }
        },
      },
    },
  }

  -- 5. Start
  jdtls.start_or_attach(config)
end

return M
