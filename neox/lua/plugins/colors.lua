--- Module containing configurations for changing colours

-- Setup binary colourscheme
require("binary").setup({
    -- NOTE: apparently this is required so that the colours are correct.
    style = "light",
    colors = {
        bg = "#24273a",
        fg = "#cad3f5",
    },
})

-- Setup a command to toggle between colours and no colours
local is_binary = false
vim.api.nvim_create_user_command("ToggleZen",
    function()
        local colourscheme = is_binary and "catppuccin-macchiato" or "binary"
        vim.cmd(string.format("colorscheme %s", colourscheme))

        -- Disable rainbow delimiters on zen mode
        local rainbow_delimiters = require("rainbow-delimiters")
        if is_binary then
            rainbow_delimiters.enable()
        else
            rainbow_delimiters.disable()
        end

        is_binary = not is_binary
    end, {}
)
