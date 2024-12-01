---Module containing the configuration of the git-related plugins

-- Lazy load Neogit on `Neogit` call
_G.neox.command_lazy_load("Neogit", "neogit", function() require("neogit").setup() end)
_G.neox.set_keymap("n", "<leader>g", ":Neogit<Cr>", nil)

-- Setup gitsigns
local gitsigns = require("gitsigns")

-- Set the configuration of gitsigns
gitsigns.setup {
    on_attach = function(bufnr)
        --- Wrapping function to simplify setting up some mappings
        local function set_keymap(mapping, action)
            _G.neox.set_keymap("n", mapping, action, { buffer = bufnr })
        end

        -- Move to the next hunk
        set_keymap("]h",
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                    return
                end
                gitsigns.nav_hunk('next')
            end
        )

        -- Move to the previous hunk
        set_keymap("[h",
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                    return
                end
                gitsigns.nav_hunk('prev')
            end
        )

        -- Some other mappings
        set_keymap("<leader>hs", gitsigns.stage_hunk)
        set_keymap("<leader>hr", gitsigns.reset_hunk)
        set_keymap("<leader>hS", gitsigns.stage_buffer)
        set_keymap("<leader>hu", gitsigns.undo_stage_hunk)
        set_keymap("<leader>hR", gitsigns.reset_buffer)
        set_keymap("<leader>hp", gitsigns.preview_hunk)
        set_keymap("<leader>hb", function() gitsigns.blame_line { full = true } end)
        set_keymap("<leader>tb", gitsigns.toggle_current_line_blame)
        set_keymap("<leader>hd", gitsigns.diffthis)
        set_keymap("<leader>hD", function() gitsigns.diffthis('~') end)
        set_keymap("<leader>td", gitsigns.toggle_deleted)
    end,
}
