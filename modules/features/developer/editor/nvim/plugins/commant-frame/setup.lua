require("nvim-comment-frame").setup({})

vim.api.nvim_set_keymap("n", "<leader>cc", ":lua require('nvim-comment-frame').add_comment()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>C", ":lua require('nvim-comment-frame').add_multiline_comment()<CR>", {})

local function section_header()
	local title = vim.fn.input("Section: ")
	if title == "" then
		return
	end

	-- "// %s" -> "//", ""   |   "/* %s */" -> "/*", " */"
	local l, r = vim.bo.commentstring:match("^(.-)%s*%%s%s*(.-)$")
	l = (l and l ~= "") and l or "//"
	r = (r and r ~= "") and (" " .. r) or ""
	local head = string.format("%s ---- %s ", l, title)

	-- insert below cursor, let indentexpr / treesitter / cindent place it
	local lnum = vim.api.nvim_win_get_cursor(0)[1] + 1
	vim.api.nvim_buf_set_lines(0, lnum - 1, lnum - 1, false, { head })
	vim.api.nvim_win_set_cursor(0, { lnum, 0 })
	vim.cmd("normal! ==")

	-- width: textwidth, else colorcolumn, else 80
	local width = vim.bo.textwidth
	if width == 0 then
		local cc = tonumber(vim.wo.colorcolumn:match("^%d+") or "")
		width = cc and (cc - 1) or 80
	end

	local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
	local used = vim.fn.strdisplaywidth(line) + vim.fn.strdisplaywidth(r)
	local fill = string.rep("-", math.max(4, width - used))
	vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { line .. fill .. r })
end

vim.keymap.set("n", "<leader>ch", section_header, { desc = "Comment section header" })
