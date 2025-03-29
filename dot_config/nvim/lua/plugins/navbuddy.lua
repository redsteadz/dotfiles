return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = { lsp = { auto_attach = true } },
  config = function(_, opts)
    require("nvim-navbuddy").setup()
  end,
}
