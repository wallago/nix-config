-- Delete the blank line below (<A-E>) or above (<A-I>) the cursor;
-- shifted siblings of the <A-e>/<A-i> inserts below. <C-e>/<C-i> are
-- half-page window scrolling now, see binds/windows.lua  ─────────────
map("n", "<A-E>", function()
	vim.cmd([[silent +g/^\s*$/d]])
	vim.cmd("noh")
end, { silent = true })

map("n", "<A-I>", function()
	vim.cmd([[silent -g/^\s*$/d]])
	vim.cmd("noh")
end, { silent = true })

-- Insert a blank line below (<A-e>) or above (<A-i>) while keeping
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
