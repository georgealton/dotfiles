return require('lazy').setup({
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'nvim-lualine/lualine.nvim',
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { 'nvim-telescope/telescope.nvim',   dependencies = { 'nvim-lua/plenary.nvim' } },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim',          build = ":MasonUpdate" },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    },
    { "catppuccin/nvim", as = "catppuccin" },
    {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    }
})
