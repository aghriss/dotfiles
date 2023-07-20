return {
	{
		"lervag/vimtex",
		config = function()
			require("custom.plugins.configs.vimtex")
		end,
		ft = "tex",
		lazy = "true",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			require("custom.plugins.configs.markdown-preview")
			require("core.utils").load_mappings("markdown")
		end,
		ft = { "markdown" },
	},
}
