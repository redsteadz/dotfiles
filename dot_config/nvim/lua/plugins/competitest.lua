return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    -- require "configs.competitest"
    require("competitest").setup {
      template_file = "~/Documents/ProjectDict/Projects/CodeQ/CF/contest/temp.cpp",
    }
  end,
  event = "VeryLazy",
  -- lazy = false,
}
