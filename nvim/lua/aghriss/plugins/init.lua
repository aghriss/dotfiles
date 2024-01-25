local get_opts = function(path)
  local f = function() return require(path) end
  return f
end

local plugins = {
  -- Basics
  {
    "folke/lazy.nvim", -- plugins manager
    lazy = false,
    dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    version = "10.0.2",
    init = function() require("aghriss.utils").load_mappings("lazy") end,
  },
  { "nvim-lua/plenary.nvim" }, -- used by other plugins for implementation
  {
    "aghriss/base46.nvim",
    -- dev = true,
    priority = 1000,
    lazy = false,
    opts = get_opts("aghriss.plugins.options.base46"),
    -- config = function(_, opts)
    -- require("base46").setup(opts)
    -- require("base46").load_all_highlights()
    -- end,
  },
  {
    "aghriss/statusline.nvim",
    -- dev = true,
    lazy = false,
    opts = get_opts("aghriss.plugins.options.statusline"),
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- for file name icon
    },
  },
  {
    "aghriss/tabufline.nvim",
    -- dev = true,
    -- dir = "/sync/repos/plugins/tabufline.nvim/",
    -- -- lazy = true,
    lazy = false,
    init = function() require("aghriss.utils").load_mappings("tabufline") end,
    opts = get_opts("aghriss.plugins.options.tabufline"),
  },

  -- Tools
  {
    "NvChad/nvterm",
    init = function() require("aghriss.utils").load_mappings("nvterm") end,
    config = function(_, opts)
      require("base46.term")
      require("nvterm").setup(opts)
    end,
  },

  -- Colors and trees
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    init = function() require("aghriss.utils").lazy_load("nvim-colorizer.lua") end,
    config = function(_, opts)
      require("colorizer").setup(opts)
      -- execute colorizer as soon as possible
      vim.defer_fn(function() require("colorizer").attach_to_buffer(0) end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require("aghriss.assets.icons").devicons }
    end,
    -- config = function(_, opts)
    -- require("base46").load_highlights("devicons")
    -- require("nvim-web-devicons").setup(opts)
    -- end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function() require("aghriss.utils").load_mappings("nvimtree") end,
    opts = get_opts("aghriss.plugins.options.nvimtree"),
    -- config = function(_, opts)
    -- require("base46").load_highlights("nvimtree")
    -- require("nvim-tree").setup(opts)
    -- vim.g.nvimtree_side = opts.view.side
    -- end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = { "base46" },
    init = function() require("aghriss.utils").lazy_load("nvim-treesitter") end,
    -- dev = true,
    -- dir = "/sync/repos/plugins/nvim-treesitter",
    -- dependencies = { "base46" },
    init = function()
      require("aghriss.utils").lazy_load("nvim-treesitter")
    end,
    lazy = false,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = get_opts("aghriss.plugins.options.treesitter"),
    -- config = function(_, opts)
    -- require("base46").load_highlights("syntax")
    -- require("base46").load_highlights("syntax")
    -- require("nvim-treesitter.configs").setup(opts)
    --   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --   parser_config.typst = {
    --     install_info = {
    --       url = "/sync/repos/plugins/tree-sitter-typst", -- local path or git repo
    --       files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    --       -- optional entries:
    --       -- branch = "main", -- default branch in case of git repo if different from master
    --       generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    --       requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    --     },
    --     filetype = "typst", -- if filetype does not match the parser name
    --   }
    -- end,
  },

  -- { "nvim-treesitter/playground", lazy = false },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    init = function()
      require("aghriss.utils").lazy_load("indent-blankline.nvim")
      require("aghriss.utils").load_mappings("blankline")
    end,
    opts = get_opts("aghriss.plugins.options.blankline"),
    -- config = function(_, opts)
    -- require("base46").load_highlights("blankline")
    -- require("indent_blankline").setup(opts)
    -- end,
  },
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system(
            "git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse"
          )
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(
              function()
                require("lazy").load({
                  plugins = { "gitsigns.nvim" },
                })
              end
            )
          end
        end,
      })
    end,
    opts = get_opts("aghriss.plugins.options.gitsigns"),
    -- config = function(_, opts)
    -- require("base46").load_highlights("git")
    -- require("gitsigns").setup(opts)
    -- end,
  },

  {
    "mbbill/undotree",
    lazy = false,
    init = function() require("aghriss.utils").load_mappings("undotree") end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    cmd = "Telescope",
    -- init = function()
    -- end,
    opts = get_opts("aghriss.plugins.options.telescope"),
    config = function(_, opts)
      local ts = require("telescope")
      ts.setup(opts)
      require("aghriss.utils").load_mappings("telescope")
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        ts.load_extension(ext)
      end
    end,
  },
  {
    "folke/which-key.nvim",
    -- lazy = false,
    keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
    init = function() require("aghriss.utils").load_mappings("whichkey") end,
    config = function(_, opts)
      require("base46").load_highlights("whichkey")
      require("which-key").setup(opts)
    end,
  },
  -- BEGIN: LSP stuff
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = get_opts("aghriss.plugins.options.null-ls"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function() require("aghriss.plugins.configs.lspconfig") end,
    init = function() require("aghriss.utils").lazy_load("nvim-lspconfig") end,
  },

  {
    "williamboman/mason.nvim",
    tag = "stable",
    cmd = {
      "Mason",
      -- "MasonInstall",
      "MasonInstallAll",
      -- "MasonUninstall",
      -- "MasonUninstallAll",
      "MasonLog",
    },
    opts = get_opts("aghriss.plugins.options.mason"),

    config = function(_,opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end
  },

  {
    "NvChad/nvim-colorizer.lua",
    init = function() require("aghriss.utils").lazy_load("nvim-colorizer.lua") end,
    opts = get_opts("aghriss.plugins.options.colorizers"),
    config = function(_, opts)
      require("colorizer").setup(opts)
      -- execute colorizer as soon as possible
      vim.defer_fn(function() require("colorizer").attach_to_buffer(0) end, 0)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("cmp").setup(require("aghriss.plugins.options.cmp"))
    end,
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = get_opts("aghriss.plugins.configs.luasnip"),
      },
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          -- setup cmp for autopairs
          require("cmp").event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
          )
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function() require("aghriss.utils").load_mappings("comment") end,
  },
  {
    "lervag/vimtex",
    init = function() require("aghriss.utils").load_mappings("vimtex") end,
    config = function()
      vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      -- quickfix opened but not activated
      vim.g.vimtex_quickfix_mode = 2
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_mappings_enabled = 0
      -- vim.g.vimtex_compiler_latexmk = {
      -- options = {
      -- "-pdf",
      -- "-verbose",
      -- "-bibtex",
      -- "-file-line-error",
      -- "-synctex=1",
      -- "--interaction=nonstopmode",
      -- },
      -- }
    end,
    ft = "tex",
    lazy = "true",
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function() require("aghriss.utils").load_mappings("markdown") end,
    config = function()
      vim.g.mkdp_browser = "chromium"
      vim.g.mkdp_theme = "light"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function() require("aghriss.utils").load_mappings("dap") end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

      require("aghriss.utils").load_mappings("dap_python")
      require("dap-python").setup(path)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
  {
    "nvim-orgmode/orgmode",
    lazy = false,
    ft = { "org" },
    opts = get_opts("aghriss.plugins.options.org"),
    config = function(_, opts)
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "aghriss/move.nvim",
    init = function() require("aghriss.utils").load_mappings("move") end,
    -- opts = { load_commands = false },
    -- opts = {},
    lazy = false,
    -- dev = true,
  },

  -- {
  --   "aghriss/telescope-test.nvim",
  --   dev = true,
  --   dir = "/home/aghriss/scratch/telescope-test.nvim/",
  --   lazy = false,
  -- },
  {
    "narutoxy/dim.lua",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("dim").setup({})
    end,
  },
  -- {
  -- "ggandor/leap.nvim",
  -- dependencies = { "tpope/vim-repeat" },
  -- lazy = false,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
      path = "/env/venv",
      pipenv_path = "/env/venv",
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      {
        -- Keymap to open VenvSelector to pick a venv.
        "<leader>vs",
        "<cmd>:VenvSelect<cr>",
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        "<leader>vc",
        "<cmd>:VenvSelectCached<cr>",
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = true,
  },
  -- {
  --   "glacambre/firenvim",
  --
  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   lazy = not vim.g.started_by_firenvim,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  --   init = function()
  --     vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  --       nested = true,
  --       command = "write",
  --     })
  --   end,
  -- },
}

return plugins
