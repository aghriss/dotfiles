-- add luarocks
--
-- vim.keymap.set("n", "<localleader>ip", function()
--   local venv = os.getenv("VIRTUAL_ENV")
--   if venv ~= nil then
--     -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
--     venv = string.match(venv, "/.+/(.+)")
--     vim.cmd(("MoltenInit %s"):format(venv))
--   else
--     vim.cmd("MoltenInit python2")
--   end
-- end, { desc = "Initialize Molten for python3", silent = true })
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 20
-- vim.g.molten_output_win_style = false
vim.g.molten_auto_open_output = false
vim.g.molten_virt_text_output = true
-- vim.g.molten_enter_output_behavior = "no_open"
vim.keymap.set(
  "n",
  "<localleader>os",
  ":noautocmd MoltenEnterOutput<CR>",
  { silent = true, desc = "show/enter output" }
)

-- vim.fn.pyeval("import molten
-- ")
