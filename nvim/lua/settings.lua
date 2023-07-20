-- color the column 80 to mark line length
local opt = vim.opt
local g = vim.g
-- local api = vim.api
-------------------------------------- options ------------------------------------------
opt.clipboard = "unnamedplus"
opt.cursorline = true
g.transparency = 0.0
-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.colorcolumn = "84"
-- which mode mouse is enabled
opt.mouse = "v"
-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = true

-- timeout when pressing leader key before showing which-key menu
opt.timeoutlen = 500
----- bindings
require("custom.keybinds")

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
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	g.neovide_transparency = 1.0
	g.neovide_background_color = ("#0f1117" .. alpha())
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
  'n-v-c:block-Cursor/lCursor-blinkwait100-blinkon500-blinkoff200',
  'i-ci:ver25-Cursor/lCursor-blinkwait200-blinkon350-blinkoff200',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon150-blinkoff150'
}
--#region
--#endregion
