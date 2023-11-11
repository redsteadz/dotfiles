-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.vscode_snippets_path = "~/Documents/ProjectsDit/Projects/CodeQ/CF"
vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_position"] = "vert"
vim.g["test#neovim#executable"] = "g++"  -- Set your compiler, e.g., "gcc" for C
vim.g["test#neovim#exec_args"] = {"-o", "a.out", "-"}
vim.g["test#neovim#term_exec"] = "./a.out"
vim.g["test#neovim#term_close"] = "kill"

