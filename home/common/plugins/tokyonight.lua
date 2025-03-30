require("tokyonight").setup({
	style = "night",

	-- Enable this to disable setting the background color
	transparent = false,

	-- Configure the colors used when opening a `:terminal` in Neovim
	terminal_colors = true,

	-- Use a darker background on sidebar-like windows
	sidebars = { "qf", "vista_kind", "terminal", "packer" },

	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
	end,

	-- Adjust specific highlight groups
	on_highlights = function(highlights, colors)
		highlights.LineNr = {
			fg = colors.yellow,
		}
	end,

	-- Set style for various syntax groups
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		-- sidebars = "dark",
		-- floats = "dark",
	},

	-- Set dim_inactive to true to dim inactive windows
	-- dim_inactive = false,

	-- Set day_brightness to a float between 0 and 1 (default is 0.3)
	-- day_brightness = 0.3,

	-- Enabling this option will hide inactive statuslines and replace them with a thin border instead
	-- hide_inactive_statusline = false,

	-- Lualine options
	-- lualine_bold = false,
})
