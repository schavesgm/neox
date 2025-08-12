---Module containing the configuration for the note-taking capabilities

-- Setup the markdown renderer
require("render-markdown").setup({
    completions = { lsp = { enabled = true }, blink = { enabled = true } },
})

-- Setup obsidian-nvim
require("obsidian").setup({
    workspaces = {
        {
            name = "vault",
            path = "~/Documents/vault"
        }
    },
    notes_subdir = "notes",
    new_notes_location = "notes_subdir",
    daily_notes = {
        folder = "journal",
        date_format = "%Y-%m-%d",
        default_tags = { "journal" },
        template = "journal.md",
    },
    templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
    },
    completion = {
        blink = true,
        nvim_cmp = false,
    },
    legacy_commands = false
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
