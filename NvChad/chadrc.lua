local M = {}
M.ui = {
	theme = "ayu_dark",
	transparency = 1,
	hl_override = {
      ColorColumn = {
        bg = "#552266",
        sp = "none",
      },
      Comment = { fg = "#cc9900"},
      Visual = {
            bg = "#555500"
        }
	},
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
