vim.g.mapleader = " "
-- ===============================
-- misc
vim.api.nvim_set_keymap(
	"n",
	"<leader>mo",
	"<C-\\><C-n>:Oil<CR>",
	{ noremap = true, silent = true, desc = "oil file explorer" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mm",
	":MarkdownPreview<CR>",
	{ noremap = true, silent = true, desc = "markdown preview" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mt",
	":ToggleTerm direction=float<CR>",
	{ noremap = true, silent = true, desc = "terminal" }
)
vim.api.nvim_set_keymap("t", "<leader>mt", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>mg",
	":Telescope live_grep<CR>",
	{ noremap = true, silent = true, desc = "live grep" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mf",
	":Telescope find_files<CR>",
	{ noremap = true, silent = true, desc = "find files" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mb",
	":Telescope buffers<CR>",
	{ noremap = true, silent = true, desc = "buffers" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mh",
	":Telescope help_tags<CR>",
	{ noremap = true, silent = true, desc = "help tags" }
)
vim.api.nvim_set_keymap("n", "<leader>mT", ":Telescope<CR>", { noremap = true, silent = true, desc = "telescope" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>mr",
	":RewindToggle<CR>",
	{ noremap = true, silent = true, desc = "rewind toggle" }
)

vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, noremap = true, silent = true, desc = "LSP renaming" })
vim.keymap.set(
	{ "v", "n" },
	"<leader>ra",
	require("actions-preview").code_actions,
	{ expr = true, noremap = true, silent = true, desc = "code actions" }
)

-- ===============================
-- focus
vim.keymap.set("n", "<leader>h", { noremap = true, silent = true, desc = "Switch window left" })
vim.keymap.set("n", "<leader>k", { noremap = true, silent = true, desc = "Switch window right" })
vim.keymap.set("n", "<leader>j", { noremap = true, silent = true, desc = "Switch window down" })
vim.keymap.set("n", "<leader>l", { noremap = true, silent = true, desc = "Switch window up" })

-- ===============================
-- tree
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle tree" })
vim.keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus tree" })
vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>", { noremap = true, silent = true, desc = "Refresh tree" })

-- ===============================
-- format File
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ lsp_fallback = true })
end, { noremap = true, silent = true, desc = "General Format file" })

-- ===============================
-- comment
vim.keymap.set("n", "<leader>c", "gcc", { remap = true, silent = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<leader>c", "gc", { remap = true, silent = true, desc = "Toggle comment" })

-- ===============================
-- buffer
vim.keymap.set("n", "<leader>bc", ":bp | bd #<CR>", { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save buffer" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Move to the next buffer" })
vim.keymap.set(
	"n",
	"<S-Tab>",
	":bprevious<CR>",
	{ noremap = true, silent = true, desc = "Move to the previous buffer" }
)
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { noremap = true, silent = true, desc = "List buffers" })

-- ===============================
-- split window
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split window vertically" })

-- ===============================
-- coc
vim.api.nvim_set_keymap(
	"n",
	"<leader>rt",
	'<Cmd>call CocAction("doHover")<CR>',
	{ noremap = true, silent = true, desc = "check type" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>rc",
	"<Plug>(coc-definition)",
	{ noremap = true, silent = true, desc = "goto definition" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>rd",
	"<Plug>(coc-type-definition)",
	{ noremap = true, silent = true, desc = "goto type definition" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ri",
	"<Plug>(coc-implementation)",
	{ noremap = true, silent = true, desc = "goto implementation" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>rr",
	"<Plug>(coc-references)",
	{ noremap = true, silent = true, desc = "goto references" }
)
vim.api.nvim_set_keymap("n", "<leader>rl", "<Cmd>CocRestart<CR>", { noremap = true, silent = true, desc = "restart" })

-- ===============================
-- git
vim.api.nvim_set_keymap(
	"n",
	"<leader>gg",
	":NeogitComment<CR>",
	{ noremap = true, silent = true, desc = "git comment" }
)
vim.api.nvim_set_keymap("n", "<leader>g+", ":NeogitLogCurrent<CR>", { noremap = true, silent = true, desc = "git log" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>gn",
	":Neogit<CR>",
	{ noremap = true, silent = true, desc = "git interface neogit" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gl",
	":LazyGit<CR>",
	{ noremap = true, silent = true, desc = "git interface lazygit" }
)
vim.api.nvim_set_keymap("n", "<leader>gp", ":Flog<CR>", { noremap = true, silent = true, desc = "git plot graph" })
-- ===============================
-- rest
vim.api.nvim_set_keymap("n", "<leader>e", ":Rest run<CR>", { noremap = true, silent = true, desc = "rest run" })

-- ===============================
-- db
-- vim.api.nvim_set_keymap('n', '<leader>a', ':<CR>', { noremap = true, silent = true, desc = "rest run" })
