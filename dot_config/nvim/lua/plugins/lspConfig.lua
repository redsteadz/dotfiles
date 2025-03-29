return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function (_, opts)
      require("lsp_signature").setup({})
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      vim.keymap.set('n', 'K', vim.lsp.buf.hover(), { desc = "Show hover information" })
      vim.keymap.set('v', '[d', vim.lsp.diagnostic.goto_prev(), { desc = "Go to previous diagnostic" })
      vim.keymap.set('v', ']d', vim.lsp.diagnostic.goto_next(), { desc = "Go to next diagnostic" })
      vim.keymap.set('v', '<C-W>d', vim.lsp.diagnostic.open_float(), { desc = "Show float diagnostics" })
      vim.keymap.set('n', '<space>q', vim.lsp.diagnostic.set_loclist(), { desc = "Set loclist" })
      require("mason-lspconfig").setup {
        ensure_installed = {
          "clangd",
          "clang-format",
          "typescript-language-server",
          "bash-language-server",
          "pyright",
          "black",
          "prettier"
        },
      }
    end,
  },
}
