local plugins = {
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
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("custom.plugins.configs.nvimtree")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
        init = function()
          require("core.utils").lazy_load "nvim-treesitter"
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
          return require "custom.plugins.opts.treesitter"
        end,
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "syntax")
          require("nvim-treesitter.configs").setup(opts)
        end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				opts = function()
					return require("custom.plugins.opts.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		tag = "stable",
		opts = {
			ensure_installed = {
				-- S:python
				"black",
				"debugpy",
				"mypy",
				"pyright",
				"ruff",
				-- E:python
				"rust-analyzer",
				"lua-language-server",
				"tailwind-language-server",
				"ltex-ls",
				"bash-language-server",
			},
		},
	},

	{
		"NvChad/nvim-colorizer.lua",
		init = function()
			require("core.utils").lazy_load("nvim-colorizer.lua")
		end,
		opts = function()
			return require("custom.plugins.opts.colorizer")
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"roobert/tailwindcss-colorizer-cmp.nvim",
			config = true,
		},
		opts = function()
			return require("custom.plugins.opts.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
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

	{
		"mfussenegger/nvim-dap",
		config = function()
			require("core.utils").load_mappings("dap")
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings("dap_python")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
return plugins
