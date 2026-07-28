require("marks").setup({
	builtin_marks = { ".", "<", ">", "^", "'" }, -- show these auto-marks too
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = { "oil", "TelescopePrompt" },
	mappings = {
		next = false,
		prev = false,
		preview = false,
		set_next = false,
		toggle = false,
		next_bookmark = false,
		prev_bookmark = false,
		delete = false,
		delete_line = false,
		delete_buf = false,
		delete_bookmark = false,
	},
})
