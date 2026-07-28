vim.keymap.set("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>")

-- Smart close: drop to previous buffer, or close the split if it
-- was the last buffer in it
local function close_buffer()
	local cur = vim.api.nvim_get_current_buf()
	local listed = vim.tbl_filter(function(b)
		return vim.bo[b].buflisted
	end, vim.api.nvim_list_bufs())

	if #listed > 1 then
		vim.cmd("BufferLineCyclePrev")
		vim.cmd("bdelete " .. cur)
	elseif vim.fn.winnr("$") > 1 then
		vim.cmd("close")
	else
		vim.cmd("bdelete")
	end
end

vim.keymap.set("n", "<leader>bd", close_buffer, { desc = "Buffer: close" })
