---Module containing the configuration for the note-taking capabilities

-- Setup orgmode plugin
require("orgmode").setup({
    org_agenda_files = "~/Documents/notes/**/*",
    org_default_notes_files = "~/Documents/notes/refile.org",
})

-- Setup the neorg plugin
require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Documents/notes",
                },
                default_workspace = "notes",
                index = "main.norg",
            },
        },
        ["core.concealer"] = {},
        ["core.export"] = {},
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
        ["core.integrations.treesitter"] = {
            config = {
                configure_parsers = true,
                install_parsers = true,
            },
        },
    },
})

-- Disable the indent blankline in neorg
local neorg_options = { pattern = "*.norg" }
_G.neox.set_autocommand("Neorg", "BufEnter", function()
    vim.cmd("IBLDisable")
end, neorg_options)
_G.neox.set_autocommand("Neorg", "BufLeave", function()
    vim.cmd("IBLEnable")
end, neorg_options)

-- Set some keybindings for neorg
_G.neox.set_autocommand("Neorg", "BufEnter", function()
    _G.neox.set_keymap("n", "<leader>nc", "<Plug>(neorg.core.looking-glass.magnify-code-block")
end, { pattern = "*.norg" })
