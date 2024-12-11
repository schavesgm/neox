---Module containing some CLI integrations for neovim

-- Setup yazi integration
_G.neox.command_lazy_load("Yazi", "yazi.nvim", function() require("yazi").setup() end)
_G.neox.set_keymap("n", "<leader>e", "<cmd>Yazi toggle<CR>")

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
