-- Set completeopt for better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Copy/Past Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit color
vim.opt.termguicolors = true


local result = vim.fn.system(vim.env.HOME .. "/.scripts/nvim_reloader.fish")
if vim.v.shell_error ~= 0 then
    require("notify")("Script execution failed: " .. result, "error")
else
    require("notify")("Script executed successfully: " .. result, "info")
end
require("notify")("Neovim start! ", "info")
