local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    -- opts = overrides.mason
    opts = {
      ensure_installed = {
        "gopls",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup{
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/projects", "~/Downloads", "/"},
        auto_restore_enabled = true,
        auto_session_enable_last_session = false,
        auto_session_use_git_branch = false,
        auto_session_root_dir = vim.fn.stdpath("data").."/sessions/",
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        vim.keymap.set("n", "<Leader>s", require("auto-session.session-lens").search_session, {
          noremap = true,
        })
      }
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "hedyhli/outline.nvim", -- :Outline
    lazy = false,
    config = function()
      require("outline").setup()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = false,
  },
  {
    "debugloop/telescope-undo.nvim",
    build = "make",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions_list = { "themes", "terms", "fzf", "undo" },
    },
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      require("core.utils").load_mappings("vm")
    end
  },
}

return plugins
