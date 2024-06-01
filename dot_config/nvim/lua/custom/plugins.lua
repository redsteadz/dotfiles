local overrides = require "custom.configs.overrides"
local leet_arg = "leetcode.nvim"
local function lazy_load_check(filetypes)
  local current_filetype = vim.bo.filetype
  for _, ft in ipairs(filetypes) do
    if ft == current_filetype then
      return false
    end
  end
  return true
end
---@type NvPluginSpec[]
local plugins = {
  {
    "folke/twilight.nvim",
    opts = {},
    lazy = false,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
    },
    lazy = false,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
    config = function(_, opts)
      require("nvim-navbuddy").setup()
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    lazy = false,
  },
  {
    "Civitasv/cmake-tools.nvim",
    config = function()
      require "custom.configs.cmake_tools"
    end,
    lazy = false,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require "custom.configs.copilot"
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    lazy = false,
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "elkowar/yuck.vim",
    ft = "yuck",
    lazy = true,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function(_, opts)
      require "custom.configs.noice"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require "custom.configs.nvim_dap"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handles = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "custom.configs.nvim_dap_ui"
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    ft = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript", "svelte", "vue" },
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
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
          path = "~/Documents/ProjectsDit/devSensei/content",
        },
      },

      -- see below for full list of options 👇
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    lazy = false,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = {
      arg = leet_arg,
      -- image_support = true,
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "rust-lang/rust.vim",
    filetype = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
    lazy = false,
  },

  {

    "3rd/image.nvim",
    opts = require "custom.configs.image",
  },
  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    config = function()
      require("carbon-now").setup { options = { theme = "nightowl" } }
    end,
    opts = { open_cmd = "brave" },
  },
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require "custom.configs.competitest"
    end,
    event = "VeryLazy",
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
    lazy = false,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {}
    end,
    keys = {
      { "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil" },
    },
    lazy = false,
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {}
    end,
    lazy = false,
  },
  {
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      { "nvim-telescope/telescope.nvim" },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require("neoclip").setup {}
    end,
  },
  lazy_load_check { "markdown", "rmarkdown", "pandoc" } and {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup {
        style = "dark",
        width = 120,
      }
    end,
    lazy = true,
  } or nil,
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup {
        mode = "term",
        focus = true,
        -- startinsert = true,
      }
    end,
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript", "svelte", "vue" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = false,
    opts = {}, -- this is equivalent to setup({})
  },

  {
    "dcampos/cmp-emmet-vim",
    require("cmp").setup {
      sources = {
        { name = "emmet_vim" },
      },
    },
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "typescriptreact", "typescript" },
    lazy = false,
  },
  -- Override plugin definition options
  {
    "0x00-ketsu/autosave.nvim",
    config = function()
      require("autosave").setup {
        enable = false,
      }
    end,
    lazy = false,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      if
        not lazy_load_check {
          "rust",
          "python",
          "javascriptreact",
          "javascript",
          "typescript",
          "typescriptreact",
          "lua",
          "c",
          "cpp",
          "html",
          "css",
          "nvim",
          "leetcode",
          "leetcode.nvim",
        }
      then
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
      end
    end, -- Override to set up mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
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

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
