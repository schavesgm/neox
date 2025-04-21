-- Basic options
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.guifont = "monospace:h17"
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 1000
vim.opt.history = 50
vim.opt.conceallevel = 0
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.infercase = true
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.colorcolumn = "100"
vim.opt.foldlevel = 99
vim.opt.winborder = "rounded"

-- Navigation options
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.numberwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

-- Buffer manipulation options
vim.opt.hidden = true
vim.opt.autoread = true

-- Invisible characters options
vim.opt.showbreak = "↪\\"
vim.opt.listchars = "tab:→\\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨"

-- Search options
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Command line menu options
vim.opt.wildmenu = true
vim.opt.wildmode = "full"

-- Spelling options
vim.opt.spell = true
vim.opt.spelllang = "en"

-- Indent options
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Special options
vim.opt.completeopt = { "menu", "menuone", "noselect" }

---Function setting up some global append options provided a list of items to append
local function set_append_option(name, values)
    for _, value in ipairs(values) do
        vim.opt[name]:append(value)
    end
end

-- Append-options
set_append_option("shortmess", { "c", "I" })
set_append_option("whichwrap", { "<", ">", "[", "]", "h", "l" })
set_append_option("clipboard", { "unnamedplus" })
