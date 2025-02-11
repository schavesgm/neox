---Module containing the configuration of the LSP capabilities

-- Setup LSP-saga
require("lspsaga").setup()

-- This will avoid an annoying layout shift in the screen
_G.vim.opt.signcolumn = "yes"

-- Solve the issue with diagnostics in the latest (1153bc) LspSaga commit
_G.vim.diagnostic.config({ severity_sort = true, })

-- Add some default keybindings to interface with LSP and LSPsaga
_G.neox.set_keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
_G.neox.set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
_G.neox.set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
_G.neox.set_keymap("n", "<leader>f", "<cmd>Lspsaga finder<CR>")
_G.neox.set_keymap("n", "<leader>tx", "<cmd>Lspsaga term_toggle<CR>")
_G.neox.set_keymap("t", "<leader>tx", "<cmd>Lspsaga term_toggle<CR>")

-- Add some commands to interface with LSPsaga
vim.api.nvim_create_user_command("Symbols", function() vim.cmd("Lspsaga outline") end, {})

---@type table Constant containing all language servers to setup in the configuration
local servers = {
    -- Python language servers
    ruff = {},
    pyright = {},

    -- Lua language servers
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim", "love" }, },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        },
    },

    -- Markdown language servers
    marksman = {},

    -- Nix language servers
    nixd = {},

    -- C-family language servers
    clangd = {}
}

---Set all keymaps in a Lsp-attached buffer
---@param bufnr number Buffer number of the LSP-attached buffer
local function _set_keymaps_on_attach(bufnr)
    local options = { buffer = bufnr }

    ---Function creating a command for Rust and for other LSP servers
    local function _create_rust_keymap(rust_command, other_command)
        local command_to_run = vim.bo.filetype == "rust" and rust_command or other_command
        return function() vim.cmd(command_to_run) end
    end

    _G.neox.set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", options)
    _G.neox.set_keymap("n", "gr", "<cmd>Lspsaga finder<CR>", options)
    _G.neox.set_keymap("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>", options)

    _G.neox.set_keymap("n", "K", _create_rust_keymap("RustLsp hover actions", "Lspsaga hover_doc"), options)
    _G.neox.set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
    _G.neox.set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)

    _G.neox.set_keymap("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", options)
    _G.neox.set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", options)
    _G.neox.set_keymap("n", "<leader>ca", _create_rust_keymap("RustLsp codeAction", "Lspsaga code_action"), options)
end

---Function to run each time an LSP client is attached to a buffer
---@param client table Table containing the client information
---@param bufnr number Buffer where the LSP is attached
local function on_attach(client, bufnr)
    -- Set the default keybindings in the attached LSP
    _set_keymaps_on_attach(bufnr)

    -- Toggle the inlay hints if possible
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end
end


---@type table Constant defining the capabilities for the language servers
local options = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
}


for client, configuration in pairs(servers) do
    local server_config = vim.tbl_deep_extend("keep", configuration, options)
    require("lspconfig")[client].setup(server_config)
end


---Setup Rust LSP capabilities
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {},
    -- LSP configuration
    server = {
        on_attach = on_attach,
        default_settings = { ['rust-analyzer'] = {}, },
    },
}
