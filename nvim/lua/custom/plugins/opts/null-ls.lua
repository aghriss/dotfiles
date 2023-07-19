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

		-- formatting.prettier,
		formatting.stylua,

		--markdown
		formatting.markdownlint,

		-- sh
		lint.shellcheck,
		formatting.shellharden,

		-- tex
		formatting.latexindent,
	},
	debug = true,
}
