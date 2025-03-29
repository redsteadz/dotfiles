return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup {
      view_options = {
        show_hidden = true
      }
    }
  end,
  keys = {
    { "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil" },
  },
  lazy = false,
}
