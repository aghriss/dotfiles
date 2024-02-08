local opt = vim.opt
local g = vim.g
g.cheatsheet_displayed = true
g.mapleader = " "
g.maplocalleader = "\\"
-------------------------------------- options ---------------------------------
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 50
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
-- opt.cmdheight = 0
g.transparency = 0.4

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
opt.scrolloff = 20
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
-- require("aghriss.neovide")
--
--cursor blinking
--#region
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor-blinkwait100-blinkon500-blinkoff200",
  "i-ci:ver25-Cursor/lCursor-blinkwait200-blinkon350-blinkoff200",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon150-blinkoff150",
}
----------------------------- options ------------------------------------------
-- disable some default providers
-- for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
for _, provider in ipairs({ "node", "perl", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH
vim.env.PATH = vim.env.HOME .. "/.local/bin" .. ":" .. vim.env.PATH

-- python provider
-- vim.g.python3_host_prog = "/env/venv/nvim/bin/python3"
vim.g.python3_host_prog = vim.fn.stdpath("data") .. "/venv/bin/python3"

vim.env.PATH = vim.fn.stdpath("data") .. "/venv/bin/" .. ":" .. vim.env.PATH
-- vim.g.loaded_python3_provider = 1

-- luarocks dependencies
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?.lua"
---------------------------- autocmds ------------------------------------------
-- local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
