-- Set completeopt for better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Copy/Past Clipboard
vim.opt.clipboard = "unnamedplus"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit color
vim.opt.termguicolors = true

require("notify")("Neovim start! ", "info")
