require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "go",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "rust",
        "python",
        "typescript",
        "yaml"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.guard = {
    install_info = {
        url = "~/work/tree-sitter-cloudformation-guard/", -- local path or git repo
        files = {
            "src/parser.c",
            "src/scanner.c"
        }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    },
}
