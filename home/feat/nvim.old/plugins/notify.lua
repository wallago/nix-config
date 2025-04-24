if vim.env.THEME == "gruvbox-light" then
	background_color = "#fbf1c7"
elseif vim.env.THEME == "tokyonight-dark" then
	background_color = "#1a1b26"
end

require("notify").setup({
	background_colour = background_color,
})
