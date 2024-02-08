local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local null_ls = require("null-ls")
-- local FORMATTING = methods.internal.FORMATTING
local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics


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
        args = {
          "--config",
          vim.fn.stdpath("config") .. "/assets/typstfmt.toml",
          -- "--verbose",
          "--output",
          "-",
        },
        to_stdin = true,
      },
      factory = h.formatter_factory,
    }),
    -- python
    -- formatting.clang_format,
    formatting.black.with({
      extra_args = function()
        return {
          "--config",
          vim.fn.stdpath("config") .. "/assets/black.toml"}
      end
    }),
    -- formatting.ruff,
    -- formatting.ruff.with({
    --   extra_args = function()
    --     return {
    --       "--config",
    --       vim.fn.stdpath("config") .. "/assets/ruff.toml"}
    --   end
    -- }),
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
    lint.ruff.with({
      extra_args = function()
        return {
          "--config",
          vim.fn.stdpath("config") .. "/assets/ruff.toml"}
      end
    }),

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
      extra_args = function()
        return { "--tab-width", "4" }
      end,
    }),
    formatting.stylua.with({
      extra_args = function()
        return {
          "--config-path",
          vim.fn.stdpath("config") .. "/assets/stylua.toml",
        }
      end,
    }),
    -- formatting.lua_format.with({
    -- extra_args = function()
    -- return {
    -- "--config",
    -- vim.fn.stdpath("config") .. "/assets/lua-format.yaml",
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
          vim.fn.stdpath("config") .. "/assets/latexindent.yaml",
          "-m",
        }
      end,
    }),
  },
  debug = true,
}
