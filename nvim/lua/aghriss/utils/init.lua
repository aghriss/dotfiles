local M = {}
local fn = vim.fn
local merge_tb = vim.tbl_deep_extend

M.load_config = function() return require("aghriss.configs") end

M.list_themes = function()
	-- local default_themes = vim.fn.readdir(vim.fn.stdpath "config" .. "/lua/base46/themes")
	local custom_themes =
		vim.loop.fs_stat(fn.stdpath("config") .. "/lua/custom/themes")
	local default_themes = {}
	if custom_themes and custom_themes.type == "directory" then
		local themes_tb = fn.readdir(fn.stdpath("config") .. "/lua/custom/themes")
		for _, value in ipairs(themes_tb) do
			default_themes[#default_themes + 1] = value
		end
	end

	for index, theme in ipairs(default_themes) do
		default_themes[index] = theme:match("(.+)%..+")
	end

	return default_themes
end

M.replace_word = function(old, new)
	local chadrc = vim.fn.stdpath("config") .. "/lua/custom/" .. "chadrc.lua"
	local file = io.open(chadrc, "r")
	if file then
		local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
		local new_content = file:read("*all"):gsub(added_pattern, new)

		file = io.open(chadrc, "w")
		if file then
			file:write(new_content)
			file:close()
		end
	end
end

M.load_mappings = function(section, mapping_opt)
	if DEBUG then
		P(section)
		P(mapping_opt)
	end
	vim.schedule(function()
		local function set_section_map(section_values)
			if section_values.plugin then return end

			section_values.plugin = nil

			for mode, mode_values in pairs(section_values) do
				local default_opts =
					merge_tb("force", { mode = mode }, mapping_opt or {})
				for keybind, mapping_info in pairs(mode_values) do
					-- merge default + user opts
					local opts =
						merge_tb("force", default_opts, mapping_info.opts or {})

					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]
					-- P(opts)
					vim.keymap.set(mode, keybind, mapping_info[1], opts)
				end
			end
		end

		local mappings = M.load_config().mappings

		if type(section) == "string" then
			mappings[section]["plugin"] = nil
			mappings = { mappings[section] }
		end

		for _, sect in pairs(mappings) do
			set_section_map(sect)
		end
	end)
end

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand("%")
			local condition = file ~= "NvimTree_1"
				and file ~= "[lazy]"
				and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load({ plugins = plugin })

						if plugin == "nvim-lspconfig" then
							vim.cmd("silent! do FileType")
						end
					end, 0)
				else
					require("lazy").load({ plugins = plugin })
				end
			end
		end,
	})
end

M.check_mappings = function()
	local mappings = M.load_config().mappings
	local key_to_plug = { i = {}, n = {}, v = {} }
	for plug, map in pairs(mappings) do
		for _, mode in ipairs({ "i", "n", "v" }) do
			if map[mode] ~= nil then
				for key, _ in pairs(map[mode]) do
					if not key_to_plug[mode][key] then
						key_to_plug[mode][key] = { plug }
					else
						table.insert(key_to_plug[mode][key], plug)
						local duplicates = key_to_plug[mode][key]
						Echo(
							"Duplicate mode: "
								.. mode
								.. ", key: '"
								.. key
								.. "', plugs:"
								.. vim.inspect(duplicates)
						)
					end
				end
			end
		end
	end
	-- P(key_to_plug)
end
return M
