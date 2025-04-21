---Module containing some CLI integrations for neovim

-- Setup Github integration using Octo
require("octo").setup({
    picker = "fzf-lua",
    picker_config = {
        use_emojis = true,
        mappings = {
            open_in_browser = { lhs = "<C-b>", desc = "Open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "Copy url to system clipboard" },
            checkout_pr = { lhs = "<C-o>", desc = "Checkout pull request" },
            merge_pr = { lhs = "<C-r>", desc = "Merge pull request" },
        },
    }
})

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
