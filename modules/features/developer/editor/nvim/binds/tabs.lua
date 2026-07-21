-- Tab ────────────────────────────────────────────────────────────────
map("n", "<leader>tn", "<CMD>tabnew<CR>", o("Tab: new"))
map("n", "<leader>tc", "<CMD>tabclose<CR>", o("Tab: close"))
map("n", "<leader>to", "<CMD>tabonly<CR>", o("Tab: close others"))
map("n", "<leader>tf", "<CMD>tabmove +1<CR>", o("Tab: move forward"))
map("n", "<leader>tb", "<CMD>tabmove -1<CR>", o("Tab: move backward"))
map("n", "]t", "gt", o("Tab: next"))
map("n", "[t", "gT", o("Tab: prev"))
