local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local null_ls = require("null-ls")
-- local FORMATTING = methods.internal.FORMATTING
local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

-- local typstfmt = {
--   method = methods.internal.FORMATTING,
--   filetypes = { "typst" },
--   generator = null_ls.formatter({
--     command = "typstfmt",
--     args = { "--output -", "$FILENAME" },
--     to_stdin = false,
--   }),
-- }
-- null_ls.register(typstfmt)
-- vim.tbl_deep_extend("keep", lspconfig, {
-- lsp_name = {
-- cmd = { "typstfmt" },
-- filetypes = { "typst" },
-- name = "typstfmt",
-- },
-- })
return {
  sources = {
    h.make_builtin({
      name = "typstfmt",
      meta = {
        url = "https://github.com/astrale-sharp/typstfmt/",
        description = "Basic formatter for the Typst language with a future!",
      },
      method = methods.internal.FORMATTING,
      filetypes = { "typst" },

      generator_opts = {
        command = "typstfmt",
        args = { "--output", "-" },
        to_stdin = true,
        -- to_stdout = true,
      },
      factory = h.formatter_factory,
    }),
    -- python
    formatting.clang_format,
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
          vim.fn.stdpath("config") .. "/lua/aghriss/assets/lsp/stylua.toml",
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
          vim.fn.stdpath("config") .. "/lua/aghriss/assets/lsp/latexindent.yaml",
          "-m",
        }
      end,
    }),
  },
  debug = true,
}
