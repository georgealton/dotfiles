vim.g.mapleader = " "

vim.keymap.set("n", "<C-P>", ":Files<CR>")
vim.keymap.set("n", "<C-?>", ":Comands<CR>")
vim.keymap.set("n", "<C-w>-", ":split<cr>")
vim.keymap.set("n", "<leader>-", ":split<cr>")
vim.keymap.set("n", "<C-w>|", ":vsplit<cr>")
vim.keymap.set("n", "<leader>|", ":vsplit<cr>")
vim.keymap.set("n", "<leader>e ",":NvimTreeToggle<cr>")

vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
vim.keymap.set("n", "<leader>g", ":TestVisit<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
