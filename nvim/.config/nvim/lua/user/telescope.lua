local actions = require "telescope.actions"
local ivy = require('telescope.themes').get_ivy()
require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true,
            theme = "ivy"
        }
    },
    defaults = {
        mappings = {
            i = {
                ["<C-y>"] = actions.send_to_qflist + actions.open_qflist
            }
        }
    }
}
