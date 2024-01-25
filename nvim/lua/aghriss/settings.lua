-- color the column 80 to mark line length
local opt = vim.opt
local g = vim.g
-- local api = vim.api
-- local config = require("aghriss.configs")
-------------------------------------- globals -----------------------------------------
-- g.nvchad_theme = config.ui.theme
g.cheatsheet_displayed = false
-- g.transparency = config.ui.transparency
g.mapleader = " "
-------------------------------------- options ---------------------------------
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 50
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
-- opt.cmdheight = 0
-- g.transparency = 0.0

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.colorcolumn = "82"
opt.fillchars = { eob = " " }
-- opt.ignorecase = true
-- opt.smartcase = true
-- which mode mouse is enabled
-- opt.mouse = "v"
opt.mouse = ""
-- Lines
opt.wrap = false
opt.listchars = "eol:↵,nbsp: ,trail: ,tab:  "
opt.list = true
-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
-- opt.ruler = true

-- disable nvim intro
opt.shortmess:append("sI")
opt.signcolumn = "auto"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.scrolloff = 8
-- timeout when pressing leader key before showing which-key menu
opt.timeoutlen = 700

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("state") .. "/undotree"
opt.undofile = true
----- bindings

-- neovide
if g.neovide then
	-- Put anything you want to happen only in Neovide her
	vim.o.guifont = "JetBrainsMono Nerd Font:h12"
	opt.linespace = 0
	g.neovide_scale_factor = 1.0
	g.neovide_padding_top = 0
	g.neovide_padding_bottom = 0
	g.neovide_padding_right = 0
	g.neovide_padding_left = 0
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor((255 * g.transparency) or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of
	-- content and title bar.
	g.neovide_transparency = 0.8
	-- g.neovide_background_color = ("#0f1117" .. alpha())
	-- hide mouse when typing
	g.neovide_hide_mouse_when_typing = true
	-- VFX Effects: railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
	g.neovide_cursor_vfx_mode = "ripple"
	g.neovide_cursor_vfx_particle_speed = 10.0
	g.neovide_cursor_vfx_opacity = 200.0

	g.neovide_cursor_vfx_particle_density = 7.0
	g.neovide_cursor_vfx_particle_lifetime = 1.5
	g.neovide_cursor_vfx_particle_phase = 10.5 -- only for railgun
	g.neovide_cursor_vfx_particle_curl = 10.0 -- only for railgun
end

--cursor blinking
--#region
vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait100-blinkon500-blinkoff200",
	"i-ci:ver25-Cursor/lCursor-blinkwait200-blinkon350-blinkoff200",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon150-blinkoff150",
}
-------------------------------------- options ------------------------------------------
-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH
vim.env.PATH = vim.env.HOME .. "/.local/bin" .. ":" .. vim.env.PATH
-------------------------------------- autocmds ------------------------------------------
-- local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- reload some chadrc options on-save
-- autocmd("BufWritePost", {
-- 	pattern = vim.tbl_map(function(path)
-- 		return vim.fs.normalize(vim.loop.fs_realpath(path))
-- 	end, vim.fn.glob(vim.fn.stdpath("config") .. "/lua/custom/**/*.lua", true, true, true)),
-- 	group = vim.api.nvim_create_augroup("ReloadNvChad", {}),
--
-- 	callback = function(opts)
-- 		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
-- 		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
-- 		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
--
-- 		require("plenary.reload").reload_module("base46")
-- 		require("plenary.reload").reload_module(module)
-- 		require("plenary.reload").reload_module("custom.chadrc")
--
-- 		-- config = require("aghriss.utils").load_config()
-- 		config = require("aghriss.configs")
--
-- 		vim.g.nvchad_theme = config.ui.theme
-- 		vim.g.transparency = config.ui.transparency
--
-- 		-- statusline
-- 		require("plenary.reload").reload_module("chadui.statusline." .. config.ui.statusline.theme)
-- 		vim.opt.statusline = "%!v:lua.require('chadui.statusline." .. config.ui.statusline.theme .. "').run()"
--
-- 		require("base46").load_all_highlights()
-- 		-- vim.cmd("redraw!")
-- 	end,
-- })

-------------------------------------- commands ------------------------------------------
-- local new_cmd = vim.api.nvim_create_user_command

-- new_cmd("NvChadUpdate", function()
-- require "nvchad.update"()
-- end, {})
