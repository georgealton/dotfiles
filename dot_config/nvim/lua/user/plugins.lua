vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-commentary' }
    use { 'wbthomason/packer.nvim' }
    use { 'nvim-tree/nvim-web-devicons' }
    use { 'nvim-tree/nvim-tree.lua' }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use {
        'nvim-lualine/lualine.nvim',
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = ":MasonUpdate"
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function() require('gitsigns').setup() end
    }

    -- Theme
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }
end)
