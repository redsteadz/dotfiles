return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  ft = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript", "svelte", "vue" },
  -- optionally, override the default options:
  config = function()
    require("tailwindcss-colorizer-cmp").setup {
      color_square_width = 2,
    }
  end,
}
