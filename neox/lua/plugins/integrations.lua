---Module containing some CLI integrations for neovim

-- Setup glow integration
require("glow").setup()

-- Setup yazi integration
require("yazi").setup()

_G.neox.set_keymap("n", "<leader>e", "<cmd>Yazi toggle<CR>")

-- Setup Github integration
require("octo").setup()
