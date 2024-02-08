local options = {
  ensure_installed = {
    "bibtex",
    "c",
    "css",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "markdown",
    -- "org",
    "typescript",
    "rust",
    "python",
    "vim",
    -- "typst",
  },
  highlight = {
    enable = true,
    -- disable = {"c", "python"},
    use_languagetree = true,
    -- additional_vim_regex_highlighting = { "org" },
  },
  indent = { enable = true },
}

-- config = function(_, opts)
-- require("base46").load_highlights("syntax")
-- require("base46").load_highlights("syntax")
-- require("nvim-treesitter.configs").setup(opts)
--   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--   parser_config.typst = {
--     install_info = {
--       url = "/sync/repos/plugins/tree-sitter-typst", -- local path or git repo
--       files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
--       -- optional entries:
--       -- branch = "main", -- default branch in case of git repo if different from master
--       generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--       requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--     },
--     filetype = "typst", -- if filetype does not match the parser name
--   }
-- end,
return options
