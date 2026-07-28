vim.lsp.config("just", {
	init_options = {
		formatting = {
			indentation = "\t",
		},
		rules = {},
	},
})
vim.lsp.enable("just")
