---@type MappingsTable


local M = {}
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue debugger",
    },
    ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up"},
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>rc"] = {":RunCode<CR>", "Runs za code", opts = {silent=true, nowait = true}},
    ["<leader>ct"] = {"<cmd> Telescope neoclip <CR>", "Open the clipboard manager"},
    ["<leader>cs"] = {"<cmd>:ASToggle<CR>", "AutoSaveToggle"},
    ["<leader>cc"] = {"<cmd>:set so=999<CR>", "Keep cursor centered"},
    ["<leader>co"] = {"<cmd>:set so=2<CR>", "Keep cursor Default"},
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
