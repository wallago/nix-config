require("bufferline").setup({
	highlights = {
		buffer_selected = {
			bold = true,
		},
		diagnostic_selected = {
			bold = true,
		},
		info_selected = {
			bold = true,
		},
		info_diagnostic_selected = {
			bold = true,
		},
		warning_selected = {
			bold = true,
		},
		warning_diagnostic_selected = {
			bold = true,
		},
		error_selected = {
			bold = true,
		},
		error_diagnostic_selected = {
			bold = true,
		},
	},
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
		show_buffer_icons = true,
		diagnostics = "nvim_lsp",
		max_prefix_length = 8,
		max_name_length = 18,
		modified_icon = "●",
		always_show_bufferline = true,
		enforce_regular_tabs = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			if context.buffer:current() then
				return ""
			end
			if level:match("error") then
				return " " .. vim.g.diagnostic_icons.Error
			elseif level:match("warning") then
				return " " .. vim.g.diagnostic_icons.Warning
			end
			return ""
		end,
		custom_filter = function(buf_number, buf_numbers)
			if vim.bo[buf_number].filetype ~= "oil" then
				return true
			end
		end,
	},

	-- options = {
	--     mode = "buffers",
	--     numbers = "none",
	--     close_command = "bdelete! %d",
	--     indicator = {
	--         -- icon = '▎',
	--         style = 'icon',
	--     },
	--     left_trunc_marker = '',
	--     right_trunc_marker = '',
	--     tab_size = 18,
	--     show_tab_indicators = true,
	--     persist_buffer_sort = true,
	--     separator_style = "thin",
	-- }
})
