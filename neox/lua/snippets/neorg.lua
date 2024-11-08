---Module containing the custom snippets for the neorg language
local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local new_snippets = {
    snippets.s("imath", format("$|{}|$", { snippets.i(1, "your_maths") }), { priority = 100000 }),
    snippets.s("icode", format("`{}`", { snippets.i(1, "your_code") }), { priority = 100000 }),
}

-- Add the snippets to the system
snippets.add_snippets("norg", new_snippets)
