vim.filetype.add {
    pattern = {
        ['.*.cfn.yaml'] = {
            priority = math.huge,
            function(path, bufnr)
                return 'cfn.yaml'
            end
        },
    },
}
