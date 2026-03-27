return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        preserve_window_proportions = true,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
      "vue", -- Make sure 'vue' is included here
      "astro",
      "svelte",
      -- Add any other filetypes where you want auto-tagging
    },
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        }, -- You can add more options here if needed
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- Database management plugins
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DB",
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBCompletionClearCache",
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
      { "<leader>dc", "<cmd>DBCompletionClearCache<cr>", desc = "Clear DB Cache" },
    },
    config = function()
      require("configs.dadbod").setup()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    dependencies = { "tpope/vim-dadbod" },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    lazy = true,
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
  -- {
  --   "adibhanna/laravel.nvim",
  --   lazy = true,
  --   ft = { "php", "blade", "php_only" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     -- optional completion providers
  --     "hrsh7th/nvim-cmp",
  --   },
  --   cmd = {
  --     "LaravelGoto",
  --     "LaravelMake",
  --     "LaravelRoute",
  --     "LaravelStatus",
  --     "Artisan",
  --     "Composer",
  --     "ComposerRequire",
  --     "ComposerRemove",
  --     "ComposerDependencies",
  --     "Sail",
  --     "SailUp",
  --     "SailDown",
  --     "SailRestart",
  --     "SailTest",
  --     "SailShare",
  --     "SailShell",
  --   },
  --   keys = {
  --     { "<leader>la", "<cmd>Artisan<cr>", desc = "Artisan" },
  --     { "<leader>lm", "<cmd>LaravelMake<cr>", desc = "Laravel Make" },
  --     { "<leader>lr", "<cmd>LaravelRoute<cr>", desc = "List Routes" },
  --     { "<leader>lg", "<cmd>LaravelGoto<cr>", desc = "Laravel Goto" },
  --     { "<leader>ls", "<cmd>LaravelStatus<cr>", desc = "Laravel Status" },
  --     { "<leader>cc", "<cmd>Composer<cr>", desc = "Composer" },
  --     { "<leader>cr", "<cmd>ComposerRequire<cr>", desc = "Composer Require" },
  --     { "<leader>cR", "<cmd>ComposerRemove<cr>", desc = "Composer Remove" },
  --     { "<leader>cdp", "<cmd>ComposerDependencies<cr>", desc = "Composer Deps" },
  --   },
  --   config = function()
  --     require("configs.laravel").setup()
  --   end,
  -- }
}
