-- Setting [OPTIONS]
-- See `:help vim.o`
--
--

-- vim.scriptencoding = 'utf-8'
-- vim.opt.encoding = 'utf-8'
-- vim.opt.fileencoding = 'utf-8'
--

-- vim.cmd.colorscheme 'catppuccin-mocha'

vim.o.wrap = true

vim.o.linebreak = true

vim.o.relativenumber = true

vim.o.number = true

vim.o.shiftwidth = 2

vim.o.tabstop = 2

vim.o.softtabstop = 2

vim.o.showmode = false

vim.opt.autoindent = true

vim.opt.cursorline = false

vim.opt.smartindent = true

vim.opt.hlsearch = true

vim.opt.showcmd = true

vim.opt.cmdheight = 1

vim.opt.laststatus = 3

vim.opt.expandtab = false

vim.opt.scrolloff = 10

-- vim.opt.smarttab = true

vim.opt.backspace = { 'start', 'eol', 'indent' }

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
