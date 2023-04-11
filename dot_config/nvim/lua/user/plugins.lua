vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'nvim-tree/nvim-web-devicons'}
    use {'nvim-tree/nvim-tree.lua'}
    use {
        'junegunn/fzf' ,
        dir = '~/.fzf',
        run = './install --all'
    }
    use {'junegunn/fzf.vim'}
    use {'tpope/vim-commentary'}
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    use {
        'nvim-lualine/lualine.nvim',
    }

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',

      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {
            'williamboman/mason.nvim',
            run = ":MasonUpdate"
        },
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lua'},
        {'saadparwaiz1/cmp_luasnip'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
      }
    }

    use {
        'w0rp/ale',
        ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function() require('gitsigns').setup() end
    }

    -- Theme
    use {
      'dracula/vim',
      as = 'dracula'
    }
    use {
        'akinsho/bufferline.nvim', 
        tag = "v3.*", 
        requires = 'nvim-tree/nvim-web-devicons'
    }
end)
