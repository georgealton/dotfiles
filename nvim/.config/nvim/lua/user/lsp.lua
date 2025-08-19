local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local configs = require 'lspconfig.configs'

local lsp = require('lsp-zero').preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = {
        set_extra_mappings = true
    },
    suggest_lsp_servers = true,
})

lsp.setup()

lsp.configure('yamlls', {
    yaml = {
        schemaStore = {
            enable = true
        }
    }
})

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lsp.configure('pyright', {
    single_file_support = false,
    on_attach = function(client, bufnr)
        local path = util.path

        -- From: https://github.com/IceS2/dotfiles/blob/master/nvim/lua/plugins_cfg/mason_ls_and_dap.lua
        local function get_python_path(workspace)
            -- Use activated virtualenv.
            if vim.env.VIRTUAL_ENV then
                return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
            end

            -- Find and use virtualenv in workspace directory.
            for _, pattern in ipairs({ "*", ".*" }) do
                local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
                if match ~= "" then
                    return path.join(vim.env.PYENV_ROOT, "versions", path.dirname(match), "bin", "python")
                end
            end

            -- Fallback to system Python.
            return exepath("python3") or exepath("python") or "python"
        end

        local function get_venv(workspace)
            for _, pattern in ipairs({ "*", ".*" }) do
                local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
                if match ~= "" then
                    return match
                end
            end
        end

        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        client.config.settings.venvPath = path.join(vim.env.PYENV_ROOT, "versions")
        client.config.settings.venv = get_venv(client.config.root_dir)
    end
})

if not configs.cloudformation then
    configs.cloudformation = {
        default_config = {
            cmd = { os.getenv("HOME") .. '/.local/bin/cfn-lsp-extra' },
            filetypes = { 'cfn.yaml' },
            root_dir = function(fname)
                return require('lspconfig').util.find_git_ancestor(fname) or vim.fn.getcwd()
            end,
            settings = {
                documentFormatting = false
            },
        },
    }
end

lspconfig.cloudformation.setup {}
