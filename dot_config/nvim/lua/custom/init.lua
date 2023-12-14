-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.vscode_snippets_path = "~/Documents/ProjectsDit/Projects/CodeQ/CF"
-- vim.opt.foldcolumn="1"
vim.opt.foldlevel=20
vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"


