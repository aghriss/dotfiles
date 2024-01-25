local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "󰅙")
lspSymbol("Info", "󰋼")
lspSymbol("Hint", "󰌵")
lspSymbol("Warn", "")

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
    relative = "cursor",
  })

-- Borders for LspInfo winodw
local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "single"
  return opts
end

local M = {}
local utils = require("aghriss.utils")

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("aghriss.utils.signature").setup(client)
  end

  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require("lspconfig")
lspconfig.ccls.setup({
  init_options = {
    -- compilationDatabaseDirectory = "build";
    -- index = {
    -- threads = 0;
    -- };
    -- clang = {
    -- excludeArgs = { "-frounding-math"} ;
    -- };
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },
})
-- python
lspconfig.pyright.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})
-- lspconfig.pylsp.setup({
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = { "W391" },
--           maxLineLength = 84,
--         },
--       },
--     },
--   },
-- })

lspconfig.rust_analyzer.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

lspconfig.typst_lsp.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "typst" },
  settings = {
    exportPdf = "onType",
  },
})
lspconfig.lua_ls.setup({
  on_attach = M.on_attach,
  -- capabilities = M.capabilities,
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        default_config = {
          max_line_length = vim.opt.colorcolumn,
          align_call_args = "true",
        },
      },
    },
  },
})

local S = require("aghriss.utils.ltex_spell")

-- instead of looping through the list of clients and check client.name == 'ltex'
-- (which many solutions out there are doing)
-- We attach the command function to the bufer then ltex is loaded
local function ltex_on_attach(client, bufnr)
  M.on_attach(client, bufnr)
  -- the second argumeng is named 'ctx', but we don't need it here
  --- command = {argument={...}, command=..., title=...}
  local addToDict = function(command, _)
    for _, arg in ipairs(command.arguments) do
      -- not the most efficent way, we could readDictFiles once per lang
      for lang, words in pairs(arg.words) do
        S.addWordsToFiles(lang, words)
        client.config.settings.ltex.dictionary = {
          [lang] = S.readDictFiles(lang),
        }
      end
    end
    -- notify the client of the new settings
    return client.notify("workspace/didChangeConfiguration", client.config.settings)
  end
  -- add the function to handle the command
  -- then lsp.commands does not find the handler,
  -- it will look at opts.handler["workspace/executeCommand"]
  vim.lsp.commands["_ltex.addToDictionary"] = addToDict
end
-- 'pluging.config.lspconfig' is from NvChad configuraion
lspconfig.ltex.setup({
  on_attach = ltex_on_attach,
  capabilities = M.capabilities,
  filetypes = { "tex", "markdown" },
  settings = {
    ltex = {
      dictionary = {
        ["en-US"] = S.readDictFiles("en-US"),
      },
    },
  },
})
-- require("plugins.configs.ltex")

lspconfig.tailwindcss.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "css", "html" },
})

lspconfig.bashls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "sh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
})

lspconfig.tsserver.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "javascript", "typescript" },
  init_options = {
    disableSuggestions = true,
  },
})
