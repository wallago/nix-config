local map = vim.keymap.set
map("n", "-", "<CMD>Oil<CR>", { desc = "Oil: parent dir" })
map("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Oil: floating window" })
map("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "File explorer (Oil)" })
