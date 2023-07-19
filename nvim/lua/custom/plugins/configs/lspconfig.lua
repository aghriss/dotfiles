local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})
lspconfig.lua_ls.setup({
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
})
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
--[[ Adding dictionary file
local path = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add'
local words = {}

for word in io.open(path, 'r'):lines() do
  table.insert(words, word)
end

nvim_lsp.ltex.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ltex = {
      disabledRules = {
        ['en-US'] = { 'PROFANITY' },
        ['en-GB'] = { 'PROFANITY' },
      },
      dictionary = {
        ['en-US'] = words,
        ['en-GB'] = words,
      },
    },
  },
}
--]]
lspconfig.ltex.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "tex", "markdown" },
	-- handlers = {
        -- ["_ltex.addToDictionay"] = function(err, result, ctx, config)
			-- print("addToDict handle: ",vim.inspect(err), vim.inspect(result), vim.inspect(ctx), vim.inspect(config))
		-- end,
		-- ["workspace/executeCommand"] = function(err, result, ctx, config)
			-- print("wkspc/execComm: ",vim.inspect(err), vim.inspect(result), vim.inspect(ctx), vim.inspect(config))
		-- end,
	-- },
})
require("custom.plugins.configs.ltex")

lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "css", "html" },
})
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
		},
	},
})
