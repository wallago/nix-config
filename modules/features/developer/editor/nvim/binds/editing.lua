-- Delete the blank line below (<C-n>) or above (<C-e>) the cursor ────
map("n", "<C-e>", function()
	vim.cmd([[silent +g/^\s*$/d]])
	vim.cmd("noh")
end, { silent = true })

map("n", "<C-i>", function()
	vim.cmd([[silent -g/^\s*$/d]])
	vim.cmd("noh")
end, { silent = true })

-- Insert a blank line below (<A-n>) or above (<A-e>) while keeping
-- the cursor put; paste mode suppresses autoindent/comment leaders ───
map("n", "<A-e>", function()
	vim.o.paste = true
	vim.cmd("normal! o")
	vim.cmd("normal! `[")
	vim.o.paste = false
end, { silent = true })

map("n", "<A-i>", function()
	vim.o.paste = true
	vim.cmd("normal! O")
	vim.cmd("normal! `[")
	vim.o.paste = false
end, { silent = true })

-- Surround the word under the cursor with quotes ─────────────────────
map("n", '<leader>"', 'ciw"<C-r>""<Esc>', o('Surround word with "'))
map("n", "<leader>'", "ciw'<C-r>\"'<Esc>", o("Surround word with '"))

-- Clear search highlight ─────────────────────────────────────────────
map("n", "<leader>\\", "<Cmd>nohlsearch<CR>", o("Clear search highlight"))
