-- Window navigation: <C-w> + n/e/i/o instead of h/j/k/l  ─────────────
map("n", "<C-w>n", "<C-w>h", o("← left"))
map("n", "<C-w>e", "<C-w>j", o("↓ bottom"))
map("n", "<C-w>i", "<C-w>k", o("↑ top"))
map("n", "<C-w>o", "<C-w>l", o("→ right"))

-- Toggle between maximized split and the restored layout  ────────────
local zoomed = false
local restore_cmd

local function toggle_zoom()
	if zoomed then
		vim.cmd(restore_cmd)
	else
		restore_cmd = vim.fn.winrestcmd()
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
	end
	zoomed = not zoomed
end

vim.keymap.set("n", "<F5>", toggle_zoom, { desc = "Toggle maximize split" })
