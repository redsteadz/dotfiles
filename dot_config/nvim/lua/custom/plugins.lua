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
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = {
      arg = leet_arg,
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
      require("competitest").setup()
    end,
    event = "VeryLazy",
  },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup()
    end,
    lazy = false,
  },
  -- {
  --     "ggandor/leap.nvim",
  --     config = function()
  --         -- require('leap').add_default_mappings()
  --     end,
  --     dependencies = { "tpope/vim-repeat" },
  --     lazy = false,
  -- },
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
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
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
    "christoomey/vim-tmux-navigator",
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
      -- {'nvim-telescope/telescope.nvim'},
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
    lazy = false,
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
      if not lazy_load_check { "rust", "python", "javascript", "typescript", "lua", "c", "cpp", "html", "css" } then
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
    "windwp/nvim-ts-autotag",
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
