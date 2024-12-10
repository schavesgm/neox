---Module containing some autocommands to use in the system

---Set a callback from a command string
---@param command string Command to use in the autocommand
---@return function Callback function to use in the autocommand
local function from_command(command)
    return function() vim.cmd(command) end
end

-- Set some basic auto-commands to allow restoring sessions
_G.neox.set_autocommand("RestoreSession", "BufRead", from_command([[call setpos('.', getpos("'\'"))]]))
_G.neox.set_autocommand("RestoreSession", "VimLeave", from_command([[wshada!]]))

-- Set some auto-commands to deal with the terminal mode
_G.neox.set_autocommand("Terminal", "TermOpen", from_command([[tnoremap <buffer> <Esc> <c-\><c-n>]]))
_G.neox.set_autocommand("Terminal", "TermOpen", from_command([[startinsert]]))
_G.neox.set_autocommand("Terminal", "TermOpen", from_command([[setlocal nonumber norelativenumber]]))
_G.neox.set_autocommand("Terminal", "TermOpen", from_command([[setlocal filetype=term]]))
_G.neox.set_autocommand("Terminal", "TermOpen", from_command([[setlocal spell!]]))

-- Set some auto-commands for the markup filetypes
_G.neox.set_autocommand(
    "Markup",
    { "BufEnter" },
    from_command([[setlocal textwidth=100 colorcolumn+=1]]),
    { pattern = { "*.tex", "*.md", "*.norg", "*.rst" } }
)
_G.neox.add_timed_autocommand(
    function(buffer) vim.cmd(string.format(":w %s", buffer)) end,
    "MarkupAutoSave",
    3.0,
    { pattern = { "*.tex", "*.md", "*.rst" } }
)
