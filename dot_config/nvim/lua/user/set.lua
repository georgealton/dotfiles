local opt            = vim.opt
local g              = vim.g

opt.guicursor        = ""

g.loaded_netrw       = 1
g.loaded_netrwPlugin = 1

opt.encoding         = "utf8"

opt.number           = true
opt.relativenumber   = true

opt.scrolloff        = 8
opt.background       = "dark"
opt.cursorline       = true

opt.hlsearch         = false
opt.incsearch        = true

opt.tabstop          = 4
opt.softtabstop      = 4
opt.shiftwidth       = 4
opt.expandtab        = true
opt.smartindent      = true

opt.signcolumn       = "yes"
opt.colorcolumn      = "80"
opt.list             = true
opt.listchars        = { space = "·", trail = "·", tab = "»_" }
opt.wrap             = false
opt.fillchars        = { eob = " " }

opt.termguicolors    = true

opt.swapfile         = false
opt.backup           = false
opt.updatetime       = 50

vim.cmd.colorscheme "catppuccin"
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
