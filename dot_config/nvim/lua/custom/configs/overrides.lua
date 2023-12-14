local M = {}


M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  autotag = {
    enable = true,
  }
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    -- c/cpp stuff
    "clangd",
    "clang-format",
    "codelldb",
    -- Rust
    "rust-analyzer",
    "rustfmt",

    --Python
    "pyright",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.nvterm = {
  cmd = "nvim",
  dir = function ()
    print("NIGGA")
    return vim.fn.expand('%:p:h')
  end,
}

function M.setup_autotag()
  local status, autotag = pcall(require, "nvim-ts-autotag")
  if not status then
    return
  end

  autotag.setup({})
end


return M
