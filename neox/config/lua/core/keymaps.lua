--- Set some keybindings in the system using the neox library

-- Set some visual model keymaps
_G.neox.set_keymap("v", "<", "<gv")
_G.neox.set_keymap("v", ">", ">gv")

-- Set some command model keymaps
_G.neox.set_keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
_G.neox.set_keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })
