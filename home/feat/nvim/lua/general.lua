
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Visual Settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Performance & UI Tweaks
vim.opt.signcolumn = "yes"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.mouse = "a"

-- Search & Navigation
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Clipboard & Yank Settings
vim.opt.clipboard = "unnamedplus"
vim.opt.history = 1000

-- Undo & Backup
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.backup = false
vim.opt.writebackup = false

-- Performance improvements
vim.opt.ttyfast = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Better split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  extends = '»',
  precedes = '«',
  nbsp = '␣'
}
