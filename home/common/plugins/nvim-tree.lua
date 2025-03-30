vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.vim_tree_tab_open = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_add_trailing = 0
vim.g.nvim_tree_group_empty = 0
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_icon_padding = " "

require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 25,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
		custom = {},
		git_ignored = false,
	},
	update_focused_file = {
		enable = true,
	},
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown" },
	},
	default = "",
	symlink = "",
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		default = "",
		open = "",
		arrow_open = "",
		arrow_closed = "",
		empty = " ",
		empty_open = " ",
		symlink = "",
		symlink_open = "",
	},
	lsp = {
		hint = " ",
		info = " ",
		warning = " ",
		error = " ",
	},
})
