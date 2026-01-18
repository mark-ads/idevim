local function esc(str)
	return vim.fn.escape(str, [[;,."|\]])
end

local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = table.concat({
	esc(ru_shift) .. ";" .. esc(en_shift),
	esc(ru) .. ";" .. esc(en),
}, ",")

-- Строки
vim.opt.number = true
vim.opt.relativenumber = false

-- Мышь и truecolor
vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- Enable sync between OS and Neowim
-- vim.o.clipboard = 'unnamedplus'

-- Display lines without breaking it to next line
vim.o.wrap = false
vim.o.linebreak = true

-- Copy indent from current line
vim.o.autoindent = true

-- Enable break indent
vim.o.breakindent = true

-- Make indent smart again
vim.o.smartindent = true

vim.o.showtabline = 1 -- show if there are at least two tabs
vim.o.backspace = "indent,eol,start" -- allow backspace on
vim.o.pumheight = 10 -- pop up menu height
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

-- Number of spaces for Tab
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Автоматически ставить вертикальную линию на 79 символов только для Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt.colorcolumn = "79"
	end,
})

-- Возможность ставить курсор на последний символ и за него
vim.o.virtualedit = "onemore"

-- Show which line your cursor is on
vim.o.cursorline = false

-- Swap / backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 750

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 6
-- Number of horizonal columns to show
vim.o.sidescrolloff = 8
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- localoptions for auto-session
vim.opt.sessionoptions:append("localoptions")
