require("checkmate").setup({
	opts = {
		files = {
			"**/pm/**/*.md", -- everything under ~/pm
			"todo.md",
			"TODO.md",
			"*.todo.md",
		},
		todo_states = {
			-- Built-in states (cannot change markdown or type)
			unchecked = { marker = "□" },
			checked = { marker = "✔" },

			-- Custom states
			in_progress = {
				marker = "◐",
				markdown = ".", -- Saved as `- [.]`
				type = "incomplete", -- Counts as "not done"
				order = 50,
			},
			cancelled = {
				marker = "✗",
				markdown = "c", -- Saved as `- [c]`
				type = "complete", -- Counts as "done"
				order = 2,
			},
			on_hold = {
				marker = "⏸",
				markdown = "/", -- Saved as `- [/]`
				type = "inactive", -- Ignored in counts
				order = 100,
			},
		},
		metadata = {
			due = {
				style = { fg = "#ff9e64" },
				key = "<leader>TD",
				get_value = function()
					return os.date("%Y-%m-%d")
				end,
			},
			target = {
				style = { fg = "#bb9af7" },
				key = "<leader>TT",
				get_value = function()
					return os.date("%Y-%m-%d")
				end,
			},
		},
	},
})
