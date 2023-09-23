-- local config = require("aghriss.utils").load_config()

local map = vim.api.nvim_set_keymap
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- local xpr = {noremap = true, expr = true}

-- Colemak Keybindings {{{
----------------------
-- keymap.set({"n", "x", "o"}, "m", "h", opts)
-- keymap.set({"n", "x", "o"}, "m", "h", opts)
-- keymap.set({"n", "x", "o"}, "m", "h", opts)
keymap.set({"n", "v"}, "m", "h", opts )
keymap.set({"n", "v"}, "n", "j", opts )
keymap.set({"n", "v"}, "e", "k", opts)
keymap.set({"n", "v"}, "i", "l", opts)
-- inverse
keymap.set({"n", "x", "o"}, "l", "m", opts)
keymap.set({"n", "x", "o"}, "h", "n", opts)
keymap.set({"n", "x", "o"}, "M", "H", opts)
keymap.set({"n", "x", "o"}, "H", "M", opts)

keymap.set({"n", "x", "o"}, "I", "L", opts)
-- Colemak Insert
keymap.set({"n", "x", "o"}, "t", "i", opts)
keymap.set({"n", "x", "o"}, "T", "I", opts)



-- Undo/redo
-- keymap.set({"n", "x", "o"}, "l", "u", opts)
-- keymap.set({"n", "x", "o"}, "l", ":<C-U>undo<CR>", opts)
-- keymap.set({"n", "x", "o"}, "gl", "u", opts)
-- keymap.set({"n", "x", "o"}, "gl", ":<C-U>undo<CR>", opts)

-- Colemak Windows
-- keymap.set({"n", "x", "o"}, "<C-W>m", "<C-W>h", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>m", "<C-W>h", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>n", "<C-W>j", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>n", "<C-W>j", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>e", "<C-W>k", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>e", "<C-W>k", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>i", "<C-W>k", opts)
-- keymap.set({"n", "x", "o"}, "<C-W>i", "<C-W>k", opts)
