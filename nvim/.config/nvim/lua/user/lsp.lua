vim.lsp.config['yamlls'] = {
    yaml = {
        schemaStore = {
            enable = true
        }
    }
}
vim.lsp.enable("yamlls")

vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
vim.lsp.enable("lua_ls")

vim.lsp.config["cloudformation"] = {
    cmd = { os.getenv("HOME") .. '/.local/bin/cfn-lsp-extra' },
    filetypes = { 'cfn.yaml' },
    settings = {
        documentFormatting = false
    },
}

vim.lsp.enable("cloudformation")
