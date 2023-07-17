local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  -- formatting.prettier,
  formatting.stylua,
  --markdown
  formatting.markdownlint,
  -- sh
  lint.shellcheck,
  formatting.shellharden,
  -- tex
  formatting.latexindent,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
