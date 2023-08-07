local utils = require("aghriss.utils")
-- M.gitsigns = {
return {
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "󰍵" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "│" },
	},
	on_attach = function(bufnr)
		utils.load_mappings("gitsigns", { buffer = bufnr })
	end,
}
