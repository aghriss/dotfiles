local U = require("aghriss.utils")
local get_opts = function(path)
  local f = function()
    return require(path)
  end
  return f
end

local plugins = {
  -- Basics
  {
    "folke/lazy.nvim", -- plugins manager
    lazy = false,
    dir = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    version = "10.0.2",
    init = function()
      U.load_mappings("lazy")
    end,
  },

  { "nvim-lua/plenary.nvim" }, -- used by other plugins for implementation
  {
    "aghriss/base46.nvim",
    -- dev = true,
    -- dir = "/sync/repos/plugins/base46.nvim",
    priority = 1000,
    build = function()
      require("base46").compile()
    end,
    lazy = false,
    opts = get_opts("aghriss.plugins.options.base46"),
    config = function(_, opts)
      require("base46").setup(opts)
      require("base46").load_all_highlights()
    end,
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
    lazy = false,
    init = function()
      U.load_mappings("tabufline")
    end,
    opts = get_opts("aghriss.plugins.options.tabufline"),
  },

  ------------------------------------------- Tools

  -- Colors and trees
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    init = function()
      U.lazy_load("nvim-colorizer.lua")
    end,
    opts = get_opts("aghriss.plugins.options.colorizers"),
    config = function(_, opts)
      require("colorizer").setup(opts)
      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require("aghriss.plugins.options.icons").devicons }
    end,
  },

  {
    "aghriss/nvim-tree.lua",
    -- commit = "27e66c2",
    -- dev = true,
    -- dir = "/sync/repos/plugins/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      U.load_mappings("nvimtree")
    end,
    opts = get_opts("aghriss.plugins.options.nvimtree"),
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- dev = true,
    -- dir = "/sync/repos/plugins/nvim-treesitter",
    -- dependencies = { "base46" },
    -- init = function()
    -- U.lazy_load("nvim-treesitter")
    -- end,
    lazy = false,
    opts = get_opts("aghriss.plugins.options.treesitter"),
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
  },

  { "nvim-treesitter/playground", lazy = false },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    init = function()
      U.lazy_load("indent-blankline.nvim")
      U.load_mappings("blankline")
    end,
    opts = get_opts("aghriss.plugins.options.blankline"),
  },
  -- Terminal & git
  {
    "NvChad/nvterm",
    init = function()
      U.load_mappings("nvterm")
    end,
    config = function(_, opts)
      require("base46.term")
      require("nvterm").setup(opts)
    end,
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
            vim.schedule(function()
              require("lazy").load({
                plugins = { "gitsigns.nvim" },
              })
            end)
          end
        end,
      })
    end,
    opts = get_opts("aghriss.plugins.options.gitsigns"),
  },
  {
    "mbbill/undotree",
    lazy = false,
    init = function()
      U.load_mappings("undotree")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    -- dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    cmd = "Telescope",
    opts = get_opts("aghriss.plugins.options.telescope"),
    config = function(_, opts)
      local ts = require("telescope")
      ts.setup(opts)
      U.load_mappings("telescope")
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        ts.load_extension(ext)
      end
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<localleader>", '"', "'", "`", "c", "v", "g" },
    config = function(_, opts)
      require("base46").load_highlights("whichkey")
      require("which-key").setup(opts)
      U.load_mappings("whichkey")
    end,
  },

  -------------------------------- BEGIN: LSP stuff
  -- Linters and  formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = get_opts("aghriss.plugins.options.null-ls"),
  },
  -- LSP servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("aghriss.plugins.configs.lspconfig")
      U.load_mappings("lspconfig")
    end,
    init = function()
      U.lazy_load("nvim-lspconfig")
    end,
  },
  -- LSP binaries installer
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
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },

  -- Code completions
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = get_opts("aghriss.plugins.options.cmp"),
    config = function(_, opts)
      require("cmp").setup(opts)
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
        "simrat39/rust-tools.nvim",
      },
    },
  },

  {
    "simrat39/rust-tools.nvim",
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
    opts = {
      tools = {
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
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
    init = function()
      U.load_mappings("comment")
    end,
  },
  {
    "lervag/vimtex",
    init = function()
      U.load_mappings("vimtex")
    end,
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
    "nvim-telescope/telescope-bibtex.nvim",
    dir = "/home/repo/plugins/telescope-bibtex.nvim",
    dev = true,
    ft = "tex",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("bibtex")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      U.load_mappings("markdown")
    end,
    config = function()
      vim.g.mkdp_browser = "chromium"
      vim.g.mkdp_theme = "dark"
      -- close browser when changing buffer
      vim.g.mkdp_auto_close = 0
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      U.load_mappings("dap")
    end,
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
      U.load_mappings("dap_python")
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
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- {
  --   "nvim-orgmode/orgmode",
  --   -- dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   lazy = false,
  --   -- ft = { "org" },
  --   opts = get_opts("aghriss.plugins.options.org"),
  --   config = function(_, opts)
  --     require("orgmode").setup(opts)
  --     require("orgmode").setup_ts_grammar()
  --   end,
  -- },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "aghriss/move.nvim",
    init = function()
      U.load_mappings("move")
    end,
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
      path = "/env/venv",
      parents = 0,
      pipenv_path = "/env/venv",
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)
      U.load_mappings("venv")
    end,
    event = "VeryLazy",
    keys = { { "<localleader>vs" }, { "<localleader>vc" } },
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
  {
    "aghriss/molten-nvim",
    dev = true,
    dir = "/sync/repos/plugins/molten-nvim",
    lazy = false,
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = {
      {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
          backend = "kitty", -- whatever backend you would like to use
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
      },
    },
    build = ":UpdateRemotePlugins",
    opts = {},
    config = function(_, opts)
      require("molten").setup(opts)
    end,
    init = function()
      require("aghriss.plugins.configs.molten")
      -- these are examples, not defaults. Please see the readme
      U.load_mappings("molten")
    end,
  },
  -- {
  --   "quarto-dev/quarto-nvim",
  --   lazy = false,
  --   opts = get_opts("aghriss.plugins.options.quarto"),
  --   config = function (_, opts)
  --     require("quarto").setup(opts)
  --     U.load_mappings("quarto")
  --   end,
  --   dependencies = {
  --     "jmbuhr/otter.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
  --
  -- {
  --   "GCBallesteros/jupytext.nvim",
  --   lazy = false,
  --   opts = {
  --     style = "markdown",
  --     output_extension = "md",
  --     force_ft = "markdown",
  --   },
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   lazy = false,
  --   after = "nvim-treesitter",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require("aghriss.plugins.configs.treesitter_objects")
  --   end,
  -- },
}

return plugins
