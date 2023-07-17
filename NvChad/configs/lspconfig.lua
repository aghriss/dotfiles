local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
}
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
-- lspconfig.texlab.setup({
--    on_attach = on_attach,
--    capabilities = capabilities,
--    filetypes = {"tex", "bib", "plaintex"},
--   settings = {
--     texlab = {
--         latexFormatter = "latexindent",
--         latexindent = {
--           modifyLineBreaks = false
--         }
--       }
--   }
-- })
lspconfig.ltex.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "tex", "markdown" },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
}
