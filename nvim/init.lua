require "core"

-- local custom_init_path = vim.api.nvim_get_runtime_file("settings", false)[1]

require("settings")


-- if custom_init_path then
  -- dofile(custom_init_path)
-- end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("utils").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)


require("ui")
require("base46").load_all_highlights()
require("lazy").setup("plugins", require("plugins.configs.lazy_nvim"))
