require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue debugger" })

map(
  "n",
  "f",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, })<CR>",
  { desc = "Hop forward" }
)
map(
  "n",
  "F",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, })<CR>",
  { desc = "Hop backward" }
)
map(
  "n",
  "t",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR,  hint_offset = -1 })<CR>",
  { desc = "Hop forward till" }
)
map(
  "n",
  "T",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR,  hint_offset = 1 })<CR>",
  { desc = "Hop backward till" }
)

map(
  "x",
  "f",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, })<CR>",
  { desc = "Hop forward" }
)
map(
  "x",
  "F",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, })<CR>",
  { desc = "Hop backward" }
)
map(
  "x",
  "t",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR,  hint_offset = -1 })<CR>",
  { desc = "Hop forward till" }
)
map(
  "x",
  "T",
  "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR,  hint_offset = 1 })<CR>",
  { desc = "Hop backward till" }
)

map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })
map("n", "<leader>rc", ":RunCode<CR>", { desc = "Runs za code", silent = true, nowait = true })
map("n", "<leader>cs", "<cmd>:ASToggle<CR>", { desc = "AutoSaveToggle" })
map("n", "<leader>cc", "<cmd>:set so=999<CR>", { desc = "Keep cursor centered" })
map("n", "<leader>cd", "<cmd>:set so=2<CR>", { desc = "Keep cursor Default" })
map("n", "=", "za", { desc = "Opens Folds" })
map("n", "<leader>rr", "<cmd> CompetiTest run<CR>", { desc = "Run test" })
map("n", "<leader>fc", "<cmd> CompetiTest receive contest<CR>", { desc = "Receive Contest" })
map("n", "<leader>fp", "<cmd> CompetiTest receive problem<CR>", { desc = "Receive Problem" })

map("v", ">", ">gv", { desc = "Indent" })
map("i", "<S-Enter>", "<Esc>o", { desc = "Shift enter ?", noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
