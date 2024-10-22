---Module containing the configuration of the autocompletion engine

-- Load the required modules
local luasnip = require("luasnip")
local nvim_cmp = require("cmp")
local lspkind = require("lspkind")

-- Set the correct complete options
vim.o.completeopt = "menu,menuone,noselect"

-- Set luasnip configuration
luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

-- Load some pre-defined snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Allow custom gitcommit snippets in neogit
luasnip.filetype_extend("NeogitCommitMessage", { "gitcommit" })


-- Set nvim-cmp configuration
nvim_cmp.setup {
    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
        }
    },
    mapping = {
        -- Select previous and next items using Ctrl + {k, j}
        ["<C-k>"] = nvim_cmp.mapping.select_prev_item(),
        ["<C-j>"] = nvim_cmp.mapping.select_next_item(),

        -- Move laterally in the docs using Ctrl + {b, f}
        ["<C-u>"] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(1), { "i", "c" }),

        -- Accept currently selected item
        ["<CR>"] = nvim_cmp.mapping.confirm({ select = true }),

        -- Use <Tab> to select items in the autocompletion
        ["<Tab>"] = nvim_cmp.mapping(function(fallback)
            if nvim_cmp.visible() then
                nvim_cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes(
                        "<Plug>luasnip-expand-or-jump",
                        true,
                        true,
                        true
                    ),
                    ""
                )
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Use shift tab to jump to luasnip expandable items
        ["<S-Tab>"] = nvim_cmp.mapping(function(fallback)
            if nvim_cmp.visible() then
                nvim_cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
                    ""
                )
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "emoji" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        { name = "neorg" },
    },
}
