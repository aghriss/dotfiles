local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

return {
	sources = {
		-- python
		formatting.black,
		-- lint.mypy.with({
		-- 	extra_args = function()
		-- 		local virtual = os.getenv("VIRTUAL_ENV")
		-- 		virtual = virtual or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
		-- 		return {
		-- 			{ "--python-executable", virtual .. "/bin/python3" },
		-- 			"--pep561-override",
		-- 		}
		-- 	end,
		-- }),
		lint.ruff,

		formatting.prettier.with({
			-- command = "npx prettier",
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
			},
		}),
		formatting.stylua.with({
			extra_args = function()
				return {
					"--config-path",
					vim.fn.stdpath("config")
						.. "/lua/aghriss/assets/lsp/stylua.toml",
				}
			end,
		}),
		-- formatting.lua_format.with({
		-- extra_args = function()
		-- return {
		-- "--config",
		-- vim.fn.stdpath("config") .. "/lua/aghriss/assets/lsp/lua-format.yaml",
		-- }
		-- end,
		-- }),

		--markdown
		-- formatting.markdownlint,

		-- sh
		lint.shellcheck,
		formatting.shellharden,

		-- tex
		formatting.latexindent.with({
			extra_args = function()
				return {
					"-l",
					vim.fn.stdpath("config")
						.. "/lua/aghriss/assets/lsp/latexindent.yaml",
					"-m",
				}
			end,
		}),
	},
	debug = true,
}
