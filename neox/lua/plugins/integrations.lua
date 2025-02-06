---Module containing some CLI integrations for neovim

-- Setup Github integration using Octo
require("octo").setup()

-- Allow markdown parsing in octo buffers
vim.treesitter.language.register("markdown", "octo")

-- Set some keymaps to autocomplete in octo
_G.neox.set_autocommand("Octo", "FileType",
    function()
        local options = { silent = true, buffer = true }
        _G.neox.set_keymap("i", "@", "@<C-x><C-o>", options)
        _G.neox.set_keymap("i", "#", "#<C-x><C-o>", options)
    end,
    { pattern = "octo" }
)
