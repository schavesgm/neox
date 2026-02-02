---Module containing the configuration of the treesitter plugin and related functionality
---Updated for nvim-treesitter 1.0+ which removed the configs module in favor of native Neovim APIs

-- Setup nvim-web-devicons and indent blankline
require("nvim-web-devicons").setup()
require("ibl").setup()

-- Enable treesitter-based highlighting for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Enable treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = false -- Start with folds open

-- Treesitter-based indentation
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(function()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
    end,
})

-- Incremental selection using treesitter nodes
-- Replaces the old incremental_selection module
local selection_stack = {}

local function select_node()
    local node = vim.treesitter.get_node()
    if not node then return end

    -- Store current node in stack for decremental selection
    table.insert(selection_stack, node)

    local sr, sc, er, ec = node:range()
    vim.api.nvim_buf_set_mark(0, "<", sr + 1, sc, {})
    vim.api.nvim_buf_set_mark(0, ">", er + 1, ec - 1, {})
    vim.cmd("normal! gv")
end

local function expand_selection()
    local node = vim.treesitter.get_node()
    if not node then return end

    local parent = node:parent()
    if parent then
        table.insert(selection_stack, parent)
        local sr, sc, er, ec = parent:range()
        vim.api.nvim_buf_set_mark(0, "<", sr + 1, sc, {})
        vim.api.nvim_buf_set_mark(0, ">", er + 1, ec - 1, {})
        vim.cmd("normal! gv")
    end
end

local function shrink_selection()
    if #selection_stack > 1 then
        table.remove(selection_stack)
        local node = selection_stack[#selection_stack]
        if node then
            local sr, sc, er, ec = node:range()
            vim.api.nvim_buf_set_mark(0, "<", sr + 1, sc, {})
            vim.api.nvim_buf_set_mark(0, ">", er + 1, ec - 1, {})
            vim.cmd("normal! gv")
        end
    end
end

-- Clear selection stack when leaving visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:n",
    callback = function()
        selection_stack = {}
    end,
})

-- Keymaps for incremental selection (matching old behavior)
vim.keymap.set("n", "<C-s>", select_node, { desc = "Start treesitter selection" })
vim.keymap.set("v", "<C-s>", expand_selection, { desc = "Expand treesitter selection" })
vim.keymap.set("v", "<BS>", shrink_selection, { desc = "Shrink treesitter selection" })
