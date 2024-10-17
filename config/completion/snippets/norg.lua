local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local entries = {
    snippets.s("imath", format("$|{}|$", { snippets.i(1, "your_maths") })),
    snippets.s("icode", format("`{}`", { snippets.i(1, "your_code") })),
}

return entries
