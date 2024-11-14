-- Module containing the configuration of the movement plugins

local harpoon = require("harpoon")

-- Setup harpoon
harpoon:setup()

_G.neox.set_keymap("n", "<leader>a", function() harpoon:list():add() end)
_G.neox.set_keymap("n", "<C-h>", function() harpoon:list():select(1) end)
_G.neox.set_keymap("n", "<C-t>", function() harpoon:list():select(2) end)
_G.neox.set_keymap("n", "<C-n>", function() harpoon:list():select(3) end)
_G.neox.set_keymap("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
_G.neox.set_keymap("n", "<C-p>", function() harpoon:list():prev() end)
_G.neox.set_keymap("n", "<C-n>", function() harpoon:list():next() end)

-- Setup flash movement keybindings
_G.neox.set_keymap({"n", "x", "o"}, "s", function() require("flash").jump() end)
_G.neox.set_keymap({"n", "x", "o"}, "S", function() require("flash").treesitter() end)
_G.neox.set_keymap("o", "r", function() require("flash").remote() end)
_G.neox.set_keymap({"o", "x"}, "R", function() require("flash").treesitter_search() end)
_G.neox.set_keymap({"c"}, "<C-s>", function() require("flash").toggle() end)
