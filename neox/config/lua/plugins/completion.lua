---Module containing the configuration of the autocompletion engine

-- Load the snippets module
local luasnip = require("luasnip")
luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave",
})

-- Load some pre-defined snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Allow custom gitcommit snippets in neogit
luasnip.filetype_extend("NeogitCommitMessage", { "gitcommit" })
luasnip.filetype_extend("octo", { "markdown" })

require("blink.cmp").setup({
	completion = {
		keyword = { range = "full" },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
	keymap = {
		preset = "default",
	},
	snippets = {
		preset = "luasnip",
	},
	signature = {
		enabled = true,
	},
})
