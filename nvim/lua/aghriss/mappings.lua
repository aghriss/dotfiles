local M = {}

M.general = {
  i = {
    ["<C-m>"] = { "<Left>", "Move left" },
    ["<C-i>"] = { "<Right>", "Move right" },
    ["<C-n>"] = { "<Down>", "Move down" },
    ["<C-e>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<localleader>wq"] = { "<cmd>q<CR>", "Quit window" },
    ["<localleader>wyq"] = { "<cmd>q!<CR>", "Force Quit window" },

    -- quickfix navigation
    -- ["A-n"] = { "<cmd>cnext<CR>zz", "Quickfix next" },
    -- ["A-e"] = { "<cmd>cprev<CR>zz", "Quickfix prev" },
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
    ["<leader>sw"] = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "Replace current word",
    },

    -- switch between windows
    ["<C-m>"] = { "<C-w>h", "Window left" },
    ["<C-n>"] = { "<C-w>j", "Window right" },
    ["<C-e>"] = { "<C-w>k", "Window down" },
    ["<C-i>"] = { "<C-w>l", "Window up" },

    -- Tabs
    ["<leader>tc"] = { ":tabnew<CR>", "Create tab" },
    ["<leader>tn"] = { ":tabnext<CR>", "Next tab" },
    ["<leader>tb"] = { ":tabfirst<CR>", "First tab" },
    ["<leader>tp"] = { ":tabprev<CR>", "Previous tab" },
    ["<leader>tl"] = { ":tablast<CR>", "Last tab" },
    -- window & tab controls
    ["<leader>wt"] = { "<Esc><C-w>T", "Turn window to tab" }, -- Check collision!
    ["<leader>sh"] = { ":sp<space>", "Horizontal split" },
    ["<leader>sv"] = { ":vsp<space>", "Vertical split" },

    -- whole file mainpulation
    ["<leader>ss"] = { "<cmd>w<CR>", "Save file" },
    ["<C-c>"] = { "<cmd>%y+<CR>", "Copy whole file" },
    ["<leader>sx"] = { "<cmd>!chmod +x %<CR>", "Make executable" },

    ["L"] = { "mzJ`z", "Merge lines" },
    -- turn on spell checker - ]s and [s to move, z= for suggestions
  },
  -- ["<leader>ls"] = { ":FixWhitespace<CR>", "" },
  -- new buffer
  -- ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
  -- merge lines and stay at same position
  -- line numbers
  -- ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
  -- ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
  -- tab controls -- ctrl-t makes a new tab

  --  Improvments
  -- ["<leader><space>"] = { ":set hlsearch!<CR>", "Highlight search" },
  -- ["<leader>sl"] = { ":set wrap linebreak<CR>", "" },

  -- highlight last inserted text
  -- ["gV"] = { "`[v]`", "" },
  --     -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
  --     -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
  --     -- empty mode is same as using <cmd> :map
  --     -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
  --     ["n"] = { 'v:count || mode(1)[0:1] == "no" ? "n" : "gn"', "Move down", opts = { expr = true } },
  -- ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
  t = {
    ["<C-x>"] = {
      vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
      "Escape terminal mode",
    },
  },

  v = {
    -- ["<Up>"] = {
    -- 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    -- "Move up",
    -- opts = { expr = true },
    -- },
    -- ["<Down>"] = {
    -- 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    -- "Move down",
    -- opts = { expr = true },
    -- },
    -- ["C-n"] = { ":m'>+1<CR>gv=gv", "Move line Down" },
    -- ["C-e"] = { ":m-2<CR>gv=gv", "Move line Up" },
    -- ["N"] = { ":m '>+1<CR>gvgv=gv", "Mode Up" },
    -- ["E"] = { ":m '<-2<CR>gvgv=gv", "Move Down" },
    --
    ["<leader>ra"] = {
      [["0y:%s/<C-r>0//g<Left><Left>]],
      "Replace current select",
    },
    ["<leader>rs"] = {
      [["0y:s/<C-r>0//g<Left><Left>]],
      "Replace current select",
    },
    ["<leader>sf"] = {
      [["1y/<C-r>1<CR>]],
      "Search for selection",
    },
    -- ["N"] = { ":m '>+1<CR>gv=gv", "Mode Up", { noremap = true, silent = true } },
    -- ["E"] = { ":m '<-2<CR>gv=gv", "Move Down", { silent = true } },
  },

  x = {
    -- ["j"] = {
    -- 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    -- "Move down",
    -- opts = { expr = true },
    -- },
    -- ["k"] = {
    -- 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    -- "Move up",
    -- opts = { expr = true },
    -- },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = {
      'p:let @+=@0<CR>:let @"=@0<CR>',
      "Dont copy replaced",
      opts = { silent = true },
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd([[normal! _]])
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("tabufline.controls").next_buffer()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("tabufline.controls").prev_buffer()
      end,
      "Goto prev buffer",
    },
    --
    -- close buffer + hide terminal buffer
    ["<leader>xx"] = {
      function()
        require("tabufline.controls").close_curbuf()
      end,
      "Close buffer",
    },
    ["<leader>xa"] = {
      function()
        require("tabufline.controls").close_all_bufs()
      end,
      "Close all buffers",
    },
    ["<leader>xo"] = {
      function()
        require("tabufline.controls").close_other_bufs()
      end,
      "Close other buffers",
    },
  },
}

M.comment = {
  plugin = true,
  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lazy = {
  plugin = true,
  n = {
    ["<leader>lz"] = { "<cmd> Lazy <CR>", "Lazy dash" },
  },
}

M.lspconfig = {
  plugin = true,
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    -- navigate diagnostics
    ["<leader>spl"] = { ":set spell spelllang=en_us<CR>", "" },
    ["<leader>spln"] = { ":set nospell<CR>", "" },
    ["<leader>lca"] = { vim.lsp.buf.code_action, "LSP code action" },
    ["<leader>lD"] = { vim.lsp.buf.definition, "LSP definition" },
    ["<leader>lgi"] = { vim.lsp.buf.implementation, "LSP implementation" },
    ["<leader>lh"] = { vim.lsp.buf.hover, "LSP hover" },
    ["<leader>ld"] = { vim.lsp.buf.declaration, "LSP declaration" },
    ["<leader>lgr"] = { vim.lsp.buf.references, "LSP references" },
    ["<leader>lgt"] = { vim.lsp.buf.type_definition, "LSP definition type" },
    ["<leader>ls"] = { vim.lsp.buf.signature_help, "LSP signature help" },
    ["<leader>lq"] = { vim.diagnostic.setloclist, "Diagnostic setloclist" },
    ["<leader>l("] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Goto prev",
    },

    ["<leader>l)"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Goto next",
    },
    -- tasks
    ["<localleader>lf"] = {
      function()
        -- limit waiting time for 5 seconds
        vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
      end,
      "LSP formatting",
    },
    ["<localleader>lr"] = {
      require("aghriss.utils.renamer").open,
      "LSP Rename var",
    },
    -- workspaces
    ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
    ["<leader>wr"] = {
      vim.lsp.buf.remove_workspace_folder,
      "Remove workspace folder",
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.markdown = {
  n = {
    ["<localleader>cm"] = { "<cmd> MarkdownPreview <CR>", "Compile Markdown" },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>tt"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>tf"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.nvterm = {
  plugin = true,
  -- terminal mode
  t = {
    -- ["<A-i>"] = {
    -- "Toggle floating term",
    -- function() require("nvterm.terminal").toggle("float") end, },

    ["<C-h>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle h-term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle vertical term",
    },
  },
  -- normal mode
  n = {
    ["<localleader>th"] = {
      function()
        -- require("nvterm.terminal").new("horizontal")
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle h-term",
    },

    ["<localleader>tv"] = {
      function()
        -- require("nvterm.terminal").new("vertical")
        require("nvterm.terminal").toggle("vertical")
      end,
      "Toggle v-term",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = {
      "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      "Find all",
    },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = {
      "<cmd> Telescope current_buffer_fuzzy_find <CR>",
      "Find in current buffer",
    },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },
    -- theme switcher
    -- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "DAP Breakpoint" },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "DAP Python test method",
    },
  },
}

M.undotree = {
  n = {
    ["<localleader>U"] = { "<cmd>UndotreeToggle<CR>", "Toggle UndoTree" },
  },
}
M.vimtex = {
  plugin = true,
  n = {
    ["<localleader>ct"] = { "<cmd>VimtexCompile<CR>", "Compile Tex" },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.move = {
  plugin = true,
  v = {
    ["<C-n>"] = { ":MoveBlock(1)<CR>", "Move" },
    ["<C-e>"] = { ":MoveBlock(-1)<CR>", "Move" },
    ["<C-m>"] = { ":MoveHBlock(-1)<CR>", "Move" },
    ["<C-i>"] = { ":MoveHBlock(1)<CR>", "Move" },
  },
}

M.venv = {
  plugin = true,
  n = {
    -- Keymap to open VenvSelector to pick a venv.
    ["<localleader>vs"] = { "<cmd>VenvSelect<CR>", "Select Venv" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    ["<localleader>vc"] = { "<cmd>:VenvSelectCached<cr>", "Load previous venv" },
  },
}

M.molten = {
  plugin = true,
  n = {
    ["<leader>ip"] = {
      function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd("MoltenInit")
        end
      end,
      "Initialize Molten for python3",
    },
  },
}

-- local runner = require("quarto.runner")
-- M.quarto = {
--   plugin = true,
--   n = {
--     ["<localleader>rc"] = { runner.run_cell, "run cell", { silent = true } },
--     ["<localleader>ra"] = {
--       runner.run_above,
--       "run cell and above",
--       { silent = true },
--     },
--     ["<localleader>rA"] = { runner.run_all, "run all cells", { silent = true } },
--     ["<localleader>rl"] = { runner.run_line, "run line", { silent = true } },
--     ["<localleader>RA"] = {
--       function()
--         runner.run_all(true)
--       end,
--       "run all cells of all languages",
--       { silent = true },
--     },
--   },
--   v = {
--     ["<localleader>r"] = { runner.run_range, "run visual range", { silent = true } },
--   },
-- }

return M
