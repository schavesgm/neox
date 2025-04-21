---Entry point of the `neox` LUA configuration

---Load the `neox` library to be used in the system
_G.neox = require("neox")

---Set the default colourscheme of the system
vim.cmd "colorscheme catppuccin-macchiato"

---Load the core configuration of the system
require("core.options")
require("core.keymaps")
require("core.autocommands")
require("core.treesitter")

---Load the LSP configuration
require("lsp")

---Load all the configured plugins
require("plugins")

---Load all the snippets
require("snippets")
