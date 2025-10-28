return require('lazy').setup({
    'github/copilot.vim',
    'mbbill/undotree',
    'vim-test/vim-test',
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        opts = {},
    },
    {
        'folke/trouble.nvim',
        opts = {
            modes = {
                diagnostics = {
                    auto_close = true,
                    auto_open = true,
                }
            }
        },
        lazy = false,
        cmd = "Trouble",
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts = {
            keymap = { preset = 'enter' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = {
                menu = {
                    auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label",      gap = 1 },
                            { "source_name" },
                        }
                    }
                },
                ghost_text = { enabled = true },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },
            signature = {
                enabled = true
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" },
        signature = { enabled = true },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = false },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine"
    },
    {
        'stevearc/oil.nvim',
        opts = {
            view_options = {
                show_hidden = true
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        lazy = false,
    }
})
