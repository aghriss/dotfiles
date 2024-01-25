local options = {
	ensure_installed = {
		-- S:python
    "clang-format",
		"black",
		"debugpy",
		"mypy",
		-- "pyright",
    "python-lsp-server",
		"ruff",
    "typescript-language-server",
		-- E:python
		"rust-analyzer",
    "typst-lsp",
		"lua-language-server",
    -- javascript, ts
		"tailwindcss-language-server",
    -- "eslint-lsp",
		"ltex-ls",
		"bash-language-server",
    "prettier", -- yaml
	}, -- not an option from mason.nvim

	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},

		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},

	max_concurrent_installers = 10,
}

return options
