--  Load the plugins required in this configuration
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

-- Setup telescope plugin
telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
        },
        mappings = {
            i = {
                ["<C-k>"] = telescope_actions.move_selection_previous,
                ["<C-j>"] = telescope_actions.move_selection_next,
            },
            n = {
                ["<esc>"] = telescope_actions.close,
                ["<CR>"] = telescope_actions.select_default,
                ["<C-x>"] = telescope_actions.select_horizontal,
                ["<C-v>"] = telescope_actions.select_vertical,
            },
        },
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    pickers = {
        find_files = {
            hidden = true,
        }
    },
}

--- Set some telescope keybindings in the system
_G.neox.set_keymap("n", "<leader>tf", "<cmd>Telescope find_files<CR>")
_G.neox.set_keymap("n", "<leader>tg", "<cmd>Telescope live_grep<CR>")
_G.neox.set_keymap("n", "<leader>tt", "<cmd>Telescope resume<cr>")
