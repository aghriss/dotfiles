local plugins = {
	{
		"NvChad/NvChad",
		lazy = true,
		dir = vim.fn.stdpath("config") .. "/",
		name = "NvChad",
	},

	{
		"folke/lazy.nvim",
		lazy = false,
		dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
		version = "10.0.2",
		init = function()
			require("core.utils").load_mappings("lazy")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		-- opts = {
		-- 	ensure_installed = {
		-- 		"bibtex",
		-- 		"c",
		-- 		"css",
		-- 		"html",
		-- 		"javascript",
		-- 		"json",
		-- 		"latex",
		-- 		"lua",
		-- 		"typescript",
		-- 		"rust",
		-- 		"python",
		-- 		"vim",
		-- 	},
		-- },

		opts = function()
			return require("custom.configs.treesitter")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("custom.configs.null-ls")
			end,
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		tag = "stable",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"pyright",
				"lua-language-server",
				-- "texlab",
				"ltex-ls",
				"bash-language-server",
			},
		},
	},

	{
		"lervag/vimtex",
		config = function()
			require("custom.configs.vimtex")
		end,
		ft = "tex",
		lazy = "false",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			require("custom.configs.markdown-preview")
			require("core.utils").load_mappings("markdown")
		end,

		ft = { "markdown" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("custom.configs.nvimtree")
		end,
	},
}
return plugins
