---Module containing some CLI integrations for neovim

-- Setup yazi integration
_G.neox.command_lazy_load("Yazi", "yazi.nvim", function() require("yazi").setup() end)
_G.neox.set_keymap("n", "<leader>e", "<cmd>Yazi toggle<CR>")

-- Setup Github integration
require("octo").setup()
