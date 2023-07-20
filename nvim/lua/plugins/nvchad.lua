return {
	"nvim-lua/plenary.nvim",

	{
		"folke/lazy.nvim",
		lazy = false,
		dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
		version = "10.0.2",
		init = function()
			require("core.utils").load_mappings("lazy")
		end,
	},
	-- nvchad plugins
	{ "NvChad/extensions", branch = "v2.0" },

	{
		name = "ui",
		lazy = false,
		config = function()
			require("ui")
		end,
	},

	{
		"NvChad/nvterm",
		init = function()
			require("utils").load_mappings("nvterm")
		end,
		config = function(_, opts)
			require("base46.term")
			require("nvterm").setup(opts)
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		init = function()
			require("utils").lazy_load("nvim-colorizer.lua")
		end,
		config = function(_, opts)
			require("colorizer").setup(opts)

			-- execute colorizer as soon as possible
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return { override = require("nvchad_ui.icons").devicons }
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "devicons")
			require("nvim-web-devicons").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.7",
		init = function()
			require("core.utils").lazy_load("indent-blankline.nvim")
		end,
		opts = function()
			return require("plugins.configs.others").blankline
		end,
		config = function(_, opts)
			require("core.utils").load_mappings("blankline")
			dofile(vim.g.base46_cache .. "blankline")
			require("indent_blankline").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "syntax")
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
