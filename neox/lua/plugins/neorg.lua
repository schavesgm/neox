---Module containing the configuration for the neorg plugin

-- Setup the plugin
require("neorg").setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.export"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.export.markdown"] = {
            config = {
                extensions = {
                    "todo-items-basic",
                    "todo-items-pending",
                    "todo-items-extended",
                    "definition-lists",
                    "mathematics",
                    "metadata",
                },
            },
        },
    },
}

-- Disable the indent blankline in neorg
local neorg_options = { pattern = "*.norg" }
_G.neox.set_autocommand("Neorg", "BufEnter", function() vim.cmd("IBLDisable") end, neorg_options)
_G.neox.set_autocommand("Neorg", "BufLeave", function() vim.cmd("IBLEnable") end, neorg_options)
