---Module containing the definition of the formatting functionality
local conform = require("conform")

-- Set the plugin formatting options
conform.setup {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        nix = { "nixfmt" },
        kotlin = { "ktlint", "ktfmt" },
    },
}

---Return the range in which the command is applied from the command arguments
---@param command_args table Table containing the command arguments
---@return table|nil
local function _get_range(command_args)
    local range = nil
    if command_args.count ~= -1 then
        local end_line =
            vim.api.nvim_buf_get_lines(0, command_args.line2 - 1, command_args.line2, true)[1]
        range = {
            start = { command_args.line1, 0 },
            ["end"] = { command_args.line2, end_line:len() },
        }
    end
    return range
end

-- Set a command to format the files using "Format"
vim.api.nvim_create_user_command(
    "Format",
    function(command_args)
        -- Get the range from the command and apply the format command
        local range = _get_range(command_args)
        conform.format({ async = true, lsp_format = "fallback", range = range })
    end,
    { range = true }
)
