require("checkmate").setup({
	files = {
		"**/sync-pm/{projects,work,perso}/*.md",
		"**/sync-pm/gateway.md", -- the Today block only renders if checkmate owns it
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
			marker = "▶",
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
			marker = "⊘",
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
		id = {
			style = { fg = "#3b4261" },
			key = "<leader>Ti",
			sort_order = 999, -- always renders last on the line
			-- Delegated to pm so manual and generated ids share one
			-- collision-checked source.
			get_value = function()
				return require("pm").new_id()
			end,
		},
		blocked = {
			style = { fg = "#f7768e" },
			key = "<leader>TB",
			sort_order = 500,
			-- Bare ids only; :PmBlock is the good path (labels + auto-stamping).
			choices = function()
				return require("pm").id_choices()
			end,
		},
	},
})
