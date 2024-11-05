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
