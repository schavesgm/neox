---Module containing the configuration of the treesitter plugin and related functionality
local treesitter = require("nvim-treesitter.configs")

-- Setup nvim-web-devicons and indent blankline
require("nvim-web-devicons").setup()
require("ibl").setup()

-- Enable treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Setup treesitter
treesitter.setup {
    -- Treesitter highlighting module
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
        use_languagetree = true,
        clear_on_cursor_move = true,
    },

    -- Treesitter incremental selection module
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-s>",
            node_incremental = "<C-s>",
            node_decremental = "<bs>",
            scope_incremental = false,
        },
    },

    -- Treesitter indentation module
    indent = {
        enable = true,
    },

    -- Autopairing module
    autopairs = {
        enable = true,
    },

    -- Textobjects module
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
        },
    },
}
