vim.g.mapleader = " "

--  Telescope
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep theme=ivy<CR>")
vim.keymap.set("n", "<leader>ft", ":Telescope theme=ivy<CR>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files theme=ivy<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers theme=ivy<CR>")
vim.keymap.set("n", "<leader>fx", ":Telescope diagnostics theme=ivy<CR>")
vim.keymap.set("n", "<leader>fd", ":Telescope lsp_definitions theme=ivy<CR>")
vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references theme=ivy<CR>")

-- Refactoring
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- Split
vim.keymap.set("n", "<C-w>-", ":split<cr>")
vim.keymap.set("n", "<leader>-", ":split<cr>")
vim.keymap.set("n", "<C-w>|", ":vsplit<cr>")
vim.keymap.set("n", "<leader>|", ":vsplit<cr>")

-- Test
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
vim.keymap.set("n", "<leader>g", ":TestVisit<CR>")

-- Move stuff in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })
