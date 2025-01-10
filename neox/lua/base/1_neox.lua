---Module containing a collection of global functions available in the configuration
---NOTE: this file should be the first one to be loaded in the configuration.
vim.cmd "colorscheme catppuccin-macchiato"

---@type table Table containing the default configuration of all keymaps
local DEFAULT_KEYMAP_OPTIONS = { noremap = true, silent = true }

---Set a keymap in the system using a simple function
---@param mode string | table Keybinding mode(s)
---@param keys string Keybinding keystroke
---@param mapping string | function Mapping to execute when the keymap is called
---@param options table | nil Optional set of options to use in the command
local function set_keymap(mode, keys, mapping, options)
    local keymap_options = vim.tbl_extend("force", DEFAULT_KEYMAP_OPTIONS, options or {})
    vim.keymap.set(mode, keys, mapping, keymap_options)
end

---Set a given autocommand in a given group
---@param group string Name of the group of this autocommand
---@param event table | string Collection of events triggering the autocommand
---@param callback function Callback to run in the autocommand
---@param options table | nil Table containing the autocommand options
local function set_autocommand(group, event, callback, options)
    local group_id = vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(
        event,
        vim.tbl_extend("force", options or {}, { group = group_id, callback = callback })
    )
end

---Table containing all opened timed_callbacks
---@type table<string, any>
local TIMED_CALLBACKS = {}

---Wrapper around callback function that generates a timed call
---@param callback function #Callback function to wrap
---@param start number #Time (in miliseconds) to pass after callback starts being called
---@param every number #Time (in miliseconds) to wait between sequential calls of the function
---@param identifier string #String identifier for the wrapped callback
---@return function #Callback function wrapped on a timed loop
local function start_timed_callback(callback, start, every, identifier)
    return function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        local timers_key = string.format("%s_%s", identifier, buffer_name)
        local lambda = vim.schedule_wrap(function()
            callback(buffer_name)
        end)
        TIMED_CALLBACKS[timers_key] = vim.loop.new_timer()
        TIMED_CALLBACKS[timers_key]:start(start, every, lambda)
    end
end

---Function to stop a timer on a callback function
---@param identifier string String identifier for the wrapped callback
---@return function #Callback function finishing the timing process
local function end_timed_callback(identifier)
    return function()
        local timers_key = string.format("%s_%s", identifier, vim.api.nvim_buf_get_name(0))
        -- If the timer does exist, then close it
        if TIMED_CALLBACKS[timers_key] ~= nil then
            TIMED_CALLBACKS[timers_key]:close()
            TIMED_CALLBACKS[timers_key] = nil
        end
    end
end

---Create a timed callback autocommand for a given identifier on "BufEnter" and "BufLeave"
---@param callback function Function to use in the callback operation
---@param identifier string Identifier for the callback operation
---@param minutes number Minutes to elapse between callbacks
---@param options table | nil Optional table adding options to the events
local function add_timed_autocommand(callback, identifier, minutes, options)
    local miliseconds = minutes * 60 * 1000

    -- Set the create timed callback auto-command on buffer enter
    set_autocommand(
        "TimedAutocommands",
        "BufEnter",
        start_timed_callback(callback, miliseconds, miliseconds, identifier),
        options
    )

    -- Set the destroy timed callback auto-command on buffer exit
    set_autocommand(
        "TimedAutocommands",
        "BufLeave",
        end_timed_callback(identifier),
        options
    )
end

---Load a plugin configuration lazily using an auto-command
---@param event table | string; Events triggering the autocommand
---@param plugin_name string; Name of the plugin package to load
---@param callback function; Callback function to execute on autocommand
---@param options table | nil; Optional table with the options passed to the autocommand
local function lazy_load(event, plugin_name, callback, options)
    set_autocommand("LazyLoad", event, function()
        vim.cmd(string.format("packadd %s", plugin_name))
        callback()
    end, options)
end

---Load a plugin configuration on an autocommand call
---@param command table | string; Commands triggering the auto-command
---@param plugin_name string; Name of the plugin package to load
---@param callback function; Callback function to execute on autocommand
local function command_lazy_load(command, plugin_name, callback)
    set_autocommand("LazyLoad", "CmdUndefined", function()
        vim.cmd(string.format("packadd %s", plugin_name))
        callback()
    end, { pattern = command })
end

---Table containing a set of functions to use in the configuration. They are accessible in all other
---scripts as it is a global table
_G.neox = {
    set_keymap = set_keymap,
    set_autocommand = set_autocommand,
    add_timed_autocommand = add_timed_autocommand,
    lazy_load = lazy_load,
    command_lazy_load = command_lazy_load,
}
