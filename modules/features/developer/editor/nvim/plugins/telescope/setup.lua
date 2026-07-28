require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-e>"] = require("telescope.actions").move_selection_next,
				["<C-i>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
})

require("telescope").load_extension("yank_history")
