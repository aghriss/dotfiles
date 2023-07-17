-- local config = require("core.utils").load_config()

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
-- local xpr = {noremap = true, expr = true}

-- Colemak Keybindings {{{
   ----------------------
   map('n', 'm', 'h', opts)
   map('x', 'm', 'h', opts)
   map('o', 'm', 'h', opts)
   map('n', 'n', 'j', opts)
   map('x', 'n', 'j', opts)
   map('o', 'n', 'j', opts)
   map('n', 'e', 'k', opts)
   map('x', 'e', 'k', opts)
   map('o', 'e', 'k', opts)
   map('n', 'i', 'l', opts)
   map('x', 'i', 'l', opts)
   map('o', 'i', 'l', opts)

  -- Colemak Insert
   map('n', 't', 'i', opts)
   map('n', 'T', 'I', opts)
   map('x', 't', 'i', opts)
   map('x', 'T', 'I', opts)
   map('o', 't', 'i', opts)
   map('o', 'T', 'I', opts)

   -- Undo/redo
   map('n', 'l', 'u', opts)
   map('x', 'l', ':<C-U>undo<CR>', opts)
   map('n', 'gl', 'u', opts)
   map('x', 'gl', ':<C-U>undo<CR>', opts)

   -- Colemak Windows
   map('n', '<C-W>m', '<C-W>h', opts)
   map('x', '<C-W>m', '<C-W>h', opts)
   map('n', '<C-W>n', '<C-W>j', opts)
   map('x', '<C-W>n', '<C-W>j', opts)
   map('n', '<C-W>e', '<C-W>k', opts)
   map('x', '<C-W>e', '<C-W>k', opts)
   map('n', '<C-W>i', '<C-W>k', opts)
   map('x', '<C-W>i', '<C-W>k', opts)

   -- window & tab controls
   map('n', '<leader>ss', ':sp<space>', opts)
   map('n', '<leader>vs', ':vsp<space>', opts)
   -- tab controls -- ctrl-t makes a new tab
   map('n', '<C-t>', '<Esc>:tabnew<CR>', opts) -- Check collision!
   -- shift T turn a split window into a tab
   map('n', '<S-T>', '<Esc><C-w>T', opts) -- Check collision!

-- }}}

-- {{{ Improvments
   map('n', '<leader><space>', ':set hlsearch!<CR>', opts)
   map('n', '<leader>sl', ':set wrap linebreak<CR>', opts)

   -- highlight last inserted text
   map('n', 'gV', '`[v]`', opts)

   -- turn on spell checker - ]s and [s to move, z= for suggestions
   map('n', '<leader>spl', ':set spell spelllang=en_us<CR>', opts)
   map('n', '<leader>nspl', ':set nospell<CR>', opts)
   map('n', '<leader>S', ':FixWhitespace<CR>', opts)

  -- move selected lines
  map("v", "E", ":m '<-2<CR>gv=gv", opts)
  map("v", "E", ":m '<-2<CR>gv=gv", opts)

  map("n", "L", "J", opts)
  map("v", "N", ":m '>+1<CR>gv=gv", opts)
-- }}}
