-- DEBUG = true
DEBUG = false
P = function(item)
  print(vim.inspect(item))
end

Echo = function(str, bold)
  bold = (bold and "bold") or ""
  vim.cmd("redraw")
  vim.api.nvim_echo({ { str, bold } }, true, {})
end

R = function(module)
  require("plenary.reload").reload_module(module)
end

require("aghriss.settings")
require("aghriss.keybinds")
require("aghriss.utils").load_mappings()

-- bootstrap lazy.nvim!
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  --------- lazy.nvim ---------------
  Echo("  Installing lazy.nvim & plugins ...")
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    repo,
    lazypath,
  })
  vim.opt.rtp:prepend(lazypath)
end

vim.opt.rtp:prepend(lazypath)

-- dofile(vim.g.base46_cache .. "defaults")

require("lazy").setup(
  require("aghriss.plugins"),
  require("aghriss.plugins.options.lazy_nvim")
)
-- require("aghriss.plugins")
-- require("chadui")
require("base46").load_all_highlights()
function LT()
  R("base46")
  require("base46").compile()
  require("base46").load_all_highlights()
end
vim.api.nvim_create_user_command("DuplicateMappings", function()
  require("aghriss.utils").check_mappings()
end, {
  desc = "Check duplicate mappings",
  force = true,
  nargs = "*",
})
