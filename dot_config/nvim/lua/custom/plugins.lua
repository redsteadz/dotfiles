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
    'elkowar/yuck.vim',
    ft = "yuck",
    lazy = true,
  },
{
  "roobert/tailwindcss-colorizer-cmp.nvim",
  -- optionally, override the default options:
  config = function()
    require("tailwindcss-colorizer-cmp").setup({
      color_square_width = 2,
    })
  end,
},
  {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
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
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  lazy = false,
},
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "mistral", -- The default model to use.
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      list_models = "<omitted lua function>", -- Retrieves a list of model names
      debug = false, -- Prints errors and the command which is run.
    },
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
    opts = {

 backend = "kitty",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    neorg = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { "norg" },
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = 50,
  max_height_window_percentage = 50,
  window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
    }
  
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
      require("competitest").setup{
        template_file = {
          cpp = "/home/red/Documents/ProjectsDit/Projects/CodeQ/CF/contest/temp.cpp",
        }
      }
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
