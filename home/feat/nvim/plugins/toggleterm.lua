require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		winblend = 0,
	},
	float_opts = {
		winblend = 0,
		border = "single", -- You can use 'single', 'double', 'rounded', 'solid', 'shadow', etc.
	},
	highlights = {
		FloatBorder = {
			guifg = vim.api.nvim_get_hl_by_name("Normal", true).background,
			guibg = vim.api.nvim_get_hl_by_name("Normal", true).background,
		},
		NormalFloat = {
			guibg = vim.api.nvim_get_hl_by_name("Normal", true).background,
		},
	},
})
