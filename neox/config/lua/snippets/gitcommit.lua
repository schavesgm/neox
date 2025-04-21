local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

---Table containing some commit scopes and their emojis
---@type table<number, table<string, string>>
local git_messages = {
    { type = "feat", emoji = "✨" },
    { type = "refactor", emoji = "♻️" },
    { type = "build", emoji = "👷" },
    { type = "perf", emoji = "⚡️" },
    { type = "fix", emoji = "🐛" },
    { type = "docs", emoji = "📝" },
    { type = "WIP", emoji = "🚧" },
}

---Generate a new commit message type to use in gitcommit
---@param commit_type string Commit type
---@param emoji string Emoji used in the scope declaration.
local function generate_new_commit_message(commit_type, emoji)
    local message = string.format("%s({}): %s {}", commit_type, emoji)
    return snippets.s(
        commit_type,
        format(message, { snippets.i(1, "scope"), snippets.i(2, "message"), }),
        { priority = 100000 }
    )
end

local new_snippets = {
    snippets.s("code", format("`{}`", { snippets.i(1, "your_code") })),
    snippets.s("link", format("[{}]({})", { snippets.i(1, "name"), snippets.i(2, "reference") })),
}

for _, entry in ipairs(git_messages) do
    new_snippets[#new_snippets + 1] = generate_new_commit_message(entry.type, entry.emoji)
end

-- Add the snippets to the system
snippets.add_snippets("gitcommit", new_snippets)
