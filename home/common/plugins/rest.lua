require("rest-nvim").setup({
	request = {
		skip_ssl_verification = true,
	},
})
require("telescope").load_extension("rest")
