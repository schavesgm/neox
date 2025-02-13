-- Module containing the configuration of the movement plugins

-- Setup the `mini` plugins
require("mini.ai").setup()
require("mini.operators").setup()
require("mini.surround").setup()

-- Setup flash movement keybindings
_G.neox.set_keymap({"n", "x", "o"}, "s", function() require("flash").jump() end)
_G.neox.set_keymap({"n", "x", "o"}, "S", function() require("flash").treesitter() end)
_G.neox.set_keymap("o", "r", function() require("flash").remote() end)
_G.neox.set_keymap({"o", "x"}, "R", function() require("flash").treesitter_search() end)
_G.neox.set_keymap({"c"}, "<C-s>", function() require("flash").toggle() end)
