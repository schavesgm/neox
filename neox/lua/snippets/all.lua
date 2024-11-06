---Module containing some generic snippets to use in the system
local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local new_snippets = {
    snippets.s("code", format("`{}`", { snippets.i(1, "default") }))
}

-- Add the snippets to the system
snippets.add_snippets("all", new_snippets)
