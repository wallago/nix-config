-- Window navigation: <C-w> + n/e/i/o instead of h/j/k/l  ─────────────
map("n", "<C-w>n", "<C-w>h", o("← left"))
map("n", "<C-w>e", "<C-w>j", o("↓ bottom"))
map("n", "<C-w>i", "<C-w>k", o("↑ top"))
map("n", "<C-w>o", "<C-w>l", o("→ right"))

vim.keymap.set("n", "<F5>", "<C-w>_<C-w>|", { desc = "Maximize split" })
