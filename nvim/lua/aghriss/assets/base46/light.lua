local M = {}

M.base_30 = {
	-- white = "#504945",
	white = "#000000",
	darker_black = "#f2e5bb",
	black = "#f7f0df", --  nvim bg
	black2 = "#e3d6ad",
	one_bg = "#e5d8af",
	one_bg2 = "#d8cba2",
	one_bg3 = "#cabd94",
	grey = "#c0b38a",
	grey_fg = "#8f8463",
	grey_fg2 = "#5e5333",
	light_grey = "#a2956c",
	red = "#d65d0e",
	baby_pink = "#af3a03",
	pink = "#9d0006",
	line = "#ded1a8", -- for lines like vertsplit
	green = "#79740e",
	vibrant_green = "#44cc44",
	nord_blue = "#7b9d90",
	blue = "#4585aa",
	yellow = "#d79921",
	sun = "#dd9f27",
	purple = "#8f3f71",
	dark_purple = "#853567",
	teal = "#749689",
	orange = "#b57614",
	cyan = "#82b3a8",
	statusline_bg = "#e9dcb3",
	lightbg = "#ddd0a7",
	pmenu_bg = "#739588",
	folder_bg = "#746d69",
}

M.base_16 = {
	base00 = "#f7f0df",
	base01 = "#e3d6ad",
	base02 = "#e5d8af",
	base03 = "#d8cba2",
	base04 = "#cabd94",
	base05 = "#504945",
	base06 = "#3c3836",
	base07 = "#000000",
	base08 = "#9d0006",
	base09 = "#af3a03",
	base0A = "#b57614",
	base0B = "#79740e",
	base0C = "#009900",
	base0D = "#076678",
	base0E = "#8f3f71",
	base0F = "#d65d0e",
}

M.type = "light"

M.polish_hl = {
	TbLineThemeToggleBtn = { fg = M.base_30.black, bg = M.base_30.white },
}

M = require("base46").override_theme(M, "light")

return M
