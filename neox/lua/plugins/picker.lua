---Module containing the telescope picker configuration

--- Set some telescope keybindings in the system
_G.neox.set_keymap("n", "<leader>ta", "<cmd>FzfLua<CR>")
_G.neox.set_keymap("n", "<leader>tf", "<cmd>FzfLua files<CR>")
_G.neox.set_keymap("n", "<leader>tb", "<cmd>FzfLua buffers<CR>")
_G.neox.set_keymap("n", "<leader>tg", "<cmd>FzfLua live_grep<CR>")
_G.neox.set_keymap("n", "<leader>tt", "<cmd>FzfLua resume<CR>")
