local M = {}
M.ui = {
	-- theme = "dark",
	theme = "dark",
	-- transparency = 1,
  theme_toggle = { "dark", "dark" },
  -- theme = "onedark", -- default theme
	hl_override = {
		-- ColorColumn = { bg = "#552266", sp = "none" },
		-- Comment = { fg = "#cc9900"},
		-- Visual = { bg = "#555500" }
	},
  ------------------------------- base46 -------------------------------------
  -- hl = highlights
  hl_add = {},
  changed_themes = {},
  transparency = false,
  lsp_semantic_tokens = false, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens

  -- https://github.com/NvChad/base46/tree/v2.0/lua/base46/extended_integrations
  extended_integrations = {}, -- these aren't compiled by default, ex: "alpha", "notify"

  -- cmp themeing
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  ------------------------------- chadui modules -----------------------------

  -- lazyload it when there are 1+ buffers
  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = true,
    overriden_modules = nil,
  },

  -- chadash (dashboard)
  chadash = {
    load_on_startup = true,

    header = {
      "▄▄▄        ▄  ▄ ▄                  ▄",
      "▄▄█        █  █ █ ▄▄▄▄▄     ▄ ▄ ▄  █",
      "█▄█▄▄▄▄▄▄▄▄█▄▄█ █ █▄█ █▄▄▄▄▄█▄█▄█▄▄█",
      "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄",
      "▄▄▄ ▄ ▄▄▄▄▄▄▄ ▄ ▄ ▄▄  ▄ ▄▄▄▄▄▄▄▄ ▄ ▄",
      "█▄█▄█▄▄▄▄▄█ ▄ █ █ █ ▄ █▄▄▄▄▄▄█ ▄ █ █",
      "█▄▄ ▄ ▄ ▄▄▄▄█▄█ █ █▄▄▄█ █▄█ ▄▄▄█▄█ █",
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "Cheatsheet" },
    },
  },

  cheatsheet = { theme = "grid" }, -- simple/grid

  lsp = {
    -- show function signatures i.e args as you type
    signature = {
      disabled = false,
      silent = true, -- silences 'no signature help available' message from appearing
    },
  },
}
-- M.plugins = "aghriss.plugins"
M.mappings = require("aghriss.mappings")
-- config for lazy.nvim startup options
-- M.lazy_nvim = require("aghriss.plugins.configs.lazy_nvim")

return M
