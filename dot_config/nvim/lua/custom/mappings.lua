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


-- M.leap = {
--   n = {
--     ["f"] = {"<Plug>(leap-forward-to)", "Leap forward to"},
--     ["F"] = {"<Plug>(leap-backward-to)", "Leap backward to"},
--     ["t"] = {"<Plug>(leap-forward-till)", "Leap forward till"},
--     ["T"] = {"<Plug>(leap-backward-till)", "Leap backward till"},
--   },
--   x = {
--     ["f"] = {"<Plug>(leap-forward-to)", "Leap forward to"},
--     ["F"] = {"<Plug>(leap-backward-to)", "Leap backward to"},
--     ["t"] = {"<Plug>(leap-forward-till)", "Leap forward till"},
--     ["T"] = {"<Plug>(leap-backward-till)", "Leap backward till"},
--   }
-- }



M.hop = {
    n = {
        ["f"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, })<CR>", "Hop forward"},
        ["F"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, })<CR>", "Hop backward"},
        ["t"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR,  hint_offset = -1 })<CR>", "Hop forward till"},
        ["T"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR,  hint_offset = 1 })<CR>", "Hop backward till"},
    },
    x = {
        ["f"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, })<CR>", "Hop forward"},
        ["F"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, })<CR>", "Hop backward"},
        ["t"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR,  hint_offset = -1 })<CR>", "Hop forward till"},
        ["T"] = {"<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR,  hint_offset = 1 })<CR>", "Hop backward till"},
    },
}

-- more keybinds!


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>rc"] = {":RunCode<CR>", "Runs za code", opts = {silent=true, nowait = true}},
    ["<leader>ct"] = {"<cmd> Telescope neoclip  extra=star,plus <CR>", "Open the clipboard manager"},
    ["<leader>cs"] = {"<cmd>:ASToggle<CR>", "AutoSaveToggle"},
    ["<leader>cc"] = {"<cmd>:set so=999<CR>", "Keep cursor centered"},
    ["<leader>cd"] = {"<cmd>:set so=2<CR>", "Keep cursor Default"},
    ["="] = {"za", "Opens Folds"},
    ["<leader>rr"] = {"<cmd> CompetiTest run<CR>", "Run test"},
    ["<leader>fc"] = {"<cmd> CompetiTest receive contest<CR>", "receive Contest"},
    ["<leader>fp"] = {"<cmd> CompetiTest receive problem<CR>", "receive Problem"},
    -- ["zM"] = {"lua require('ufo').closeAllFolds <CR>", "Opens Folds"},

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
  i = {
    ["<S-Enter>"]  = {'<Esc>o',"Shift enter ?", opts = { noremap = true, silent = true }}
  },
}

-- more keybinds!

return M
