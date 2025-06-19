--- Module containing the implementation of the copilot integration inside neovim

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

require("avante").setup({
    provider = "openai",
    auto_suggestions_provider = "openai",
	input = {
		provider = "native",
		provider_opts = {
			-- Snacks input configuration
			title = "Avante Input",
			icon = " ",
			placeholder = "Enter your API key...",
		},
	},
})
