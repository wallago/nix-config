-- Displaced keys

-- HJKL - NEIO
-- |||| - ||||
-- vvvv - vvvv
-- NEIO - HKLJ

-- QWERTY
-- h key
vim.keymap.set({ "n", "x" }, "n", "h", { noremap = true, desc = "Left" })
vim.keymap.set({ "n" }, "N", "H", { noremap = true, desc = "Top line of window" })
vim.keymap.set({ "n", "x" }, "<C-w>n", "<C-w>h", { noremap = true, desc = "Left" })
vim.keymap.set({ "n" }, "<C-w>N", "<C-w>H", { noremap = true, desc = "Move far left" })
-- j key
vim.keymap.set({ "n", "x" }, "e", "j", { noremap = true, desc = "Down / {count} lines down" })
vim.keymap.set({ "n" }, "E", "J", { noremap = true, desc = "Join line below to current" })
vim.keymap.set({ "n", "x" }, "<C-w>e", "<C-w>j", { noremap = true, desc = "Down" })
vim.keymap.set({ "n" }, "<C-w>E", "<C-w>J", { noremap = true, desc = "Move down" })
-- k key
vim.keymap.set({ "n", "x" }, "i", "k", { noremap = true, desc = "Up / {count} lines up" })
vim.keymap.set({ "n" }, "I", "K", { noremap = true, desc = "Show hover information" })
vim.keymap.set({ "n", "x" }, "<C-w>i", "<C-w>k", { noremap = true, desc = "Up" })
vim.keymap.set({ "n" }, "<C-w>I", "<C-w>K", { noremap = true, desc = "Move up" })
-- l key
vim.keymap.set({ "n", "x" }, "o", "l", { noremap = true, desc = "Right" })
vim.keymap.set({ "n" }, "O", "L", { noremap = true, desc = "Bottom line of window" })
vim.keymap.set({ "n", "x" }, "<C-w>o", "<C-w>l", { noremap = true, desc = "Right" })
vim.keymap.set({ "n" }, "<C-w>O", "<C-w>L", { noremap = true, desc = "Move far right" })

-- QWFPBJ
-- n key
vim.keymap.set({ "n" }, "h", "n", { noremap = true, desc = "Jump to next match" })
vim.keymap.set({ "n" }, "H", "N", { noremap = true, desc = "Jump to previous match" })
-- e key
vim.keymap.set({ "n" }, "k", "e", { noremap = true, desc = "Next end of word" })
vim.keymap.set({ "n" }, "K", "E", { noremap = true, desc = "Next end of WORD" })
vim.keymap.set({ "n" }, "<C-k>", "<C-e>", { noremap = true, desc = "Scroll down" })
-- i key
vim.keymap.set({ "n" }, "l", "i", { noremap = true, desc = "Insert before cursor" })
vim.keymap.set({ "n" }, "L", "I", { noremap = true, desc = "Insert at beginning of line" })
vim.keymap.set({ "n" }, "<C-l>", "<C-i>", { noremap = true, desc = "Next completion item" })
-- o key
vim.keymap.set({ "n" }, "j", "o", { noremap = true, desc = "Open new line below" })
vim.keymap.set({ "n" }, "J", "O", { noremap = true, desc = "Join line below to current" })
vim.keymap.set({ "x" }, "j", "o", { noremap = true, desc = "Move to other end of selection" })
vim.keymap.set({ "x" }, "J", "O", { noremap = true, desc = "Move to other corner of block" })
vim.keymap.set({ "n", "x" }, "<C-w>j", "<C-w>o", { noremap = true, desc = "Close all other windows" })

-- Others

-- Wick key
-- https://ncs.dev/
local wk = require("which-key")

vim.keymap.set("i", "<C-/>", function()
	wk.show({ mode = "i" })
end, { desc = "Show insert mode keys" })

vim.keymap.set("n", "<C-/>", function()
	wk.show({ mode = "n" })
end, { desc = "Show normal mode keys" })

-- Missing desc
wk.add({
	-- Nav
	{ "g_", desc = "last CHAR of line", mode = "n" },
	{ "G", desc = "Last line / {count} go to line", mode = "n" },
	{
		"<C-d>",
		desc = "Move half page down",
		mode = "n",
		"<cmd>lua require('neoscroll').ctrl_d({ duration = 250 })<cr>",
	},
	{
		"<C-u>",
		desc = "Move half page up",
		mode = "n",
		"<cmd>lua require('neoscroll').ctrl_u({ duration = 250 })<cr>",
	},
	{
		"<C-f>",
		desc = "Move page down",
		mode = "n",
		"<cmd>lua require('neoscroll').ctrl_f({ duration = 450 })<cr>",
	},
	{
		"<C-b>",
		desc = "Move page up",
		mode = "n",
		"<cmd>lua require('neoscroll').ctrl_b({ duration = 450 })<cr>",
	},
	{
		"<C-y>",
		desc = "Scroll up",
		mode = "n",
		"<cmd>lua require('neoscroll').scroll(-0.1, { move_cursor=false, duration = 100 })<cr>",
	},
	{
		"<C-k>",
		desc = "Scroll down",
		mode = "n",
		"<cmd>lua require('neoscroll').scroll(0.1, { move_cursor=false, duration = 100 })<cr>",
	},
	{ "(", desc = "Prev sentence", mode = "n" },
	{ ")", desc = "Next sentence", mode = "n" },
	{ "{", desc = "Prev paragraph", mode = "n" },
	{ "}", desc = "Next paragraph", mode = "n" },

	-- Insert
	{ "a", desc = "Append after cursor", mode = "n" },
	{ "A", desc = "Append at eol", mode = "n" },
	{ "<C-c>", desc = "Exit insert", mode = "i" },
	{ "<C-h>", desc = "Delete char before cursor", mode = "i" },
	{ "<C-w>", desc = "Delete word before cursor", mode = "i" },
	{ "<C-u>", desc = "Delete line before cursor", mode = "i" },
	{ "<C-t>", desc = "Indent line", mode = "i" },
	{ "<C-d>", desc = "Un-indent line", mode = "i" },
	{ "<C-n>", desc = "Auto-complete next match", mode = "i" },
	{ "<C-p>", desc = "Auto-complete prev match", mode = "i" },
	{ "<C-a>", desc = "Insert prev inserted text", mode = "i" },

	-- Editing
	{ "r", desc = "Replace char", mode = "n" },
	{ "R", desc = "Replace", mode = "n" },
	{ "gJ", desc = "Join line below without space", mode = "n" },
	-- { "cc", desc = "Change entire line", mode = "n" },
	{ "C", desc = "Change to eol", mode = "n" },
	{ "s", desc = "Delete char + Insert", mode = "n" },
	{ "S", desc = "Delete line + Insert", mode = "n" },
	{ "x", desc = "Delete char under cursor", mode = "n" },
	{ "X", desc = "Delete char before cursor", mode = "n" },
	-- { "dd", desc = "Delete line", mode = "n" },
	{ "D", desc = "Delete to eol", mode = "n" },
	{ "u", desc = "Undo", mode = "n" },
	{ "U", desc = "Undo all changes on line", mode = "n" },
	{ "<C-r>", desc = "Redo", mode = "n" },
	{ ".", desc = "Repeat last command", mode = "n" },
	{ ">>", desc = "Indent line", mode = "n" },
	{ "<<", desc = "Un-indent line", mode = "n" },
	{ "==", desc = "Auto indent line", mode = "n" },
	-- { "gg=G", desc = "Auto indent file", mode = "n" },

	-- Visual
	{ "<C-v>", desc = "Visual block", mode = "n" },
	{ "u", desc = "Lowercase", mode = "v" },
	{ "U", desc = "Uppercase", mode = "v" },
	{ "I", desc = "Block insert (add text to each line)", mode = "v" },
	{ "A", desc = "Block append (add text at end of each line)", mode = "v" },
	{ ":", desc = "Enter command mode for selection", mode = "v" },

	-- Copy & Paste
	{ "Y", desc = "Yank entire line", mode = "n" },
	{ "<C-n>", desc = "Cycling next entry", mode = "n", "<Plug>(YankyNextEntry)" },
	{ "<C-p>", desc = "Cycling prev entry", mode = "n", "<Plug>(YankyPreviousEntry)" },
	{ "p", desc = "Paste after cursor", mode = "n", "<Plug>(YankyPutAfter)" },
	{ "P", desc = "Paste before cursor", mode = "n", "<Plug>(YankyPutBefore)" },
	{ "gp", desc = "Paste after cursor + move cursor at end", mode = "n", "<Plug>(YankyGPutAfter)" },
	{ "gP", desc = "Paste before cursor + move cursor at end", mode = "n", "<Plug>(YankyGPutBefore)" },
	{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Paste after with indent", mode = "n" },
	{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before with indent", mode = "n" },
	{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Paste after with indent", mode = "n" },
	{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before with indent", mode = "n" },
	{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Paste after + shift right", mode = "n" },
	{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Paste after + shift left", mode = "n" },
	{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Paste before + shift right", mode = "n" },
	{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Paste before + shift left", mode = "n" },
	{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Paste after + reindent", mode = "n" },
	{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Paste before + reindent", mode = "n" },
	-- { '"_d', desc = "Delete without yanking (black hole)", mode = "n" }, -- to debug
	-- { '"0p', desc = "Paste from yank register", mode = "n" }, -- to debug
	-- { '"+y', desc = "Yank to system clipboard", mode = "n" }, -- to debug
	-- { '"+p', desc = "Paste from system clipboard", mode = "n" }, -- to debug
	-- { '"*y', desc = "Yank to primary selection", mode = "n" }, -- to debug
	-- { '"*p', desc = "Paste from primary selection", mode = "n" }, -- to debug

	-- Search & Replace
	{ "*", desc = "Search forward for word under cursor", mode = "n" },
	{ "#", desc = "Search backward for word under cursor", mode = "n" },
	{ "g*", desc = "Search forward for partial word", mode = "n" },
	{ "g#", desc = "Search backward for partial word", mode = "n" },
	{ "<leader>h", desc = "Clear search highlighting", mode = "n", "<cmd>noh<cr>" },
	-- { "cgn", desc = "Change next search match", mode = "n" },

	-- File
	{ "<leader>p", desc = "Show current directory", mode = "n", "<cmd>pwd<cr>" },
	{ "<C-s>", desc = "Save file", mode = "n", "<cmd>w<cr>" },
	{ "ZZ", desc = "Save and quit", mode = "n" },
	{ "ZQ", desc = "Quit without saving", mode = "n" },
	{ "<leader>g", desc = "Open live grep", mode = "n", "<cmd>Telescope live_grep<cr>" },
	{ "<leader>f", desc = "Open find file", mode = "n", "<cmd>Telescope find_files<cr>" },

	-- Buffers
	{ "<leader>b", group = "Buffer", mode = "n" },
	{ "<leader>bl", desc = "List all buffers", mode = "n", "<cmd>Telescope buffers<cr>" },
	{ "[b", desc = "Previous buffer", mode = "n", "<cmd>bp<cr>" },
	{ "]b", desc = "Next buffer", mode = "n", "<cmd>bn<cr>" },
	{ "<leader>bd", desc = "Delete buffer", mode = "n", "<cmd>bd<cr>" },

	-- Windows

	-- Tabs -- not sure
	{ "<leader><tab>", group = "Tabs", mode = "n" },
	{ "<leader><tab><tab>", desc = "Open new tab", mode = "n", "<cmd>tabnew<cr>" },
	{ "<leader><tab>d", desc = "Close current tab", mode = "n", "<cmd>tabc<cr>" },
	{ "<leader><tab>o", desc = "Close all other tabs", mode = "n", "<cmd>tabo<cr>" },
	{ "gt", desc = "Go to next tab / {count} go to tab", mode = "n" },

	-- Marks & Jumps
	{ "'", desc = "Jump to mark (line)", mode = "n" },
	{ "`", desc = "Jump to mark (exact pos)", mode = "n" },
	{ "``", desc = "Jump to last position before jump", mode = "n" },
	{ "'`", desc = "Jump to last position before jump", mode = "n" },
	{ "<leader>m", group = "Marks", mode = "n" },
	{ "<leader>ml", desc = "List all marks", mode = "n", "<cmd>marks<cr>" },
	{ "<leader>md", desc = "Delete all lowercase marks", mode = "n", "<cmd>delmarks!<cr>" },
	{ "<C-o>", desc = "Jump to older position in jump list", mode = "n" },
	{ "<C-i>", desc = "Jump to newer position in jump list", mode = "n" },
	{ "g;", desc = "Jump to older change position", mode = "n" },
	{ "g,", desc = "Jump to newer change position", mode = "n" },

	-- Macros
	{ "q", desc = "Stop recording macro", mode = "n" },
	{ "@@", desc = "Repeat last played macro", mode = "n" },

	-- Registers
	{ '"_', desc = "Black hole register", mode = "n" },
	{ "<leader>r", desc = "List all registers", mode = "n", "<cmd>reg<cr>" },

	-- Text Objects

	-- Folding
	{ "zn", desc = "Disable folding", mode = "n" },
	{ "zN", desc = "Enable folding", mode = "n" },
	{ "[z", desc = "Move to start of fold", mode = "n" },
	{ "]z", desc = "Move to end of fold", mode = "n" },
	{ "zj", desc = "Move to next fold", mode = "n" },
	{ "zk", desc = "Move to prev fold", mode = "n" },
	{
		"zK",
		'<cmd>lua require("ufo").peekFoldedLinesUnderCursor()<cr>',
		desc = "Peek fold or hover",
		mode = "n",
	},

	-- Ex Command

	-- Lsp & Diagnostics
	{ "gd", desc = "Go to definition", mode = "n", "<cmd>Lspsaga goto_definition<cr>" },
	{ "gD", desc = "Go to type definition", mode = "n", "<cmd>Lspsaga goto_type_definition<cr>" },
	{ "I", mode = "n", "<cmd>Lspsaga hover_doc<cr>" },
	{ "<leader>c", group = "Lsp", mode = "n" },
	{ "<leader>cn", desc = "Rename symbol", mode = "n", "<cmd>Lspsaga rename<cr>" },
	{ "<leader>ca", desc = "Code action", mode = "n", "<cmd>Lspsaga code_action<cr>" },
	{ "<leader>cf", desc = "Finder", mode = "n", "<cmd>Lspsaga finder<cr>" },
	{ "<leader>cd", desc = "Peek definition", mode = "n", "<cmd>Lspsaga peek_definition<cr>" },
	{ "<leader>cD", desc = "Peek type definition", mode = "n", "<cmd>Lspsaga peek_type_definition<cr>" },
	-- { "<leader>f", desc = "Format document", mode = "n" },
	{ "<leader>e", desc = "Show diagnostic float", mode = "n", "<cmd>Trouble diagnostics toggle<cr>" },
	{ "<leader>q", desc = "Add diagnostics to quickfix", mode = "n" },
	{ "<leader>cl", desc = "Show LSP information", mode = "n", "<cmd>LspInfo<cr>" },
	{ "<leader>cr", desc = "Show LSP restart", mode = "n", "<cmd>LspRestart<cr>" },
	{ "<leader>cs", desc = "Show LSP start", mode = "n", "<cmd>LspStart<cr>" },
	{ "<leader>co", desc = "Show LSP stop", mode = "n", "<cmd>LspStop<cr>" },
	{ "[d", desc = "Prev diagnostic", mode = "n", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
	{ "]d", desc = "Next diagnostic", mode = "n", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
	{ "[w", desc = "Prev warning", mode = "n" },
	{ "]w", desc = "Next warning", mode = "n" },
	{ "[e", desc = "Prev error", mode = "n" },
	{ "]e", desc = "Next error", mode = "n" },

	-- Completion
	{ "<C-y>", desc = "Confirm completion", mode = "i" },
	{ "<C-e>", desc = "Cancel completion", mode = "i" },
	{ "<C-x><C-o>", desc = "Omni completion", mode = "i" },
	{ "<C-x><C-f>", desc = "File name completion", mode = "i" },
	{ "<C-x><C-l>", desc = "Line completion", mode = "i" },
	{ "<C-x><C-k>", desc = "Dictionary completion", mode = "i" },
	{ "<C-x><C-]>", desc = "Tag completion", mode = "i" },
	{ "<C-x><C-n>", desc = "Keyword completion (current file)", mode = "i" },
	{ "<C-x><C-i>", desc = "Keyword completion (includes)", mode = "i" },

	-- Spell Checking
	{ "<leader>s", group = "Spell Checking", mode = "n" },
	{ "<leader>ss", desc = "Enable spell checking", mode = "n", "<cmd>set spell<cr>" },
	{ "<leader>sd", desc = "Disable spell checking", mode = "n", "<cmd>set nospell<cr>" },
	{ "<leader>sr", desc = "Repeat replacement for all", mode = "n", "<cmd>spellr<cr>" },
	{ "zug", desc = "Undo adding word to dictionary", mode = "n" },

	-- Quickfix List
	{ "<leader>x", group = "Quickfix", mode = "n" },
	{ "<leader>xq", desc = "Open quickfix window", mode = "n", "<cmd>copen<cr>" },
	{ "<leader>xc", desc = "Close quickfix window", mode = "n", "<cmd>cclose<cr>" },
	{ "[q", "<cmd>cprev<cr>", desc = "Previous quickfix item", mode = "n" },
	{ "]q", "<cmd>cnext<cr>", desc = "Next quickfix item", mode = "n" },

	-- Diff

	-- Nvim

	-- Todo
	{ "[t", "<cmd>lua require('todo-comments').jump_prev()<cr>", desc = "Previous TODO", mode = "n" },
	{ "]t", "<cmd>lua require('todo-comments').jump_next()<cr>", desc = "Next TODO", mode = "n" },

	-- Trouble
	{ "<leader>t", group = "Trouble", mode = "n" },
	{ "<leader>tt", desc = "Next TODO", mode = "n", "<cmd>Trouble todo<cr>" },
	{
		"<leader>tT",
		desc = "Todo/Fix/Fixme (Trouble)",
		mode = "n",
		"<cmd>Trouble todo filter={tag={TODO,FIX,FIXME}}<cr>",
	},
	{ "<leader>tl", desc = "Location List (Trouble)", mode = "n", "<cmd>Trouble loclist toggle<cr>" },
	{ "<leader>tq", desc = "Quickfix List (Trouble)", mode = "n", "<cmd>Trouble qflist toggle<cr>" },
	{
		"<leader>tx",
		desc = "Buffer Diagnostics (Trouble)",
		mode = "n",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	},

	-- Markdown
	{ "<leader>d", desc = "Toggle markdown preview", mode = "n", "<cmd>MarkdownPreviewToggle<cr>" },

	-- Oil
	{ "<C-e>", desc = "Open Oil", mode = "n", "<cmd>Oil<cr>" },

	-- Jujutsu
	{ "<leader>j", group = "Jujutsu" },
	{ "<leader>jd", "<cmd>J desc<cr>", desc = "Description", mode = "n" },
	{ "<leader>jS", "<cmd>J st<cr>", desc = "Status", mode = "n" },
	{ "<leader>jl", "<cmd>J log<cr>", desc = "Log", mode = "n" },
	{ "<leader>j=", "<cmd>J diff<cr>", desc = "Diff", mode = "n" },
	{ "<leader>jn", "<cmd>J new<cr>", desc = "New", mode = "n" },
	{ "<leader>je", "<cmd>J edit<cr>", desc = "Edit", mode = "n" },
	{ "<leader>js", "<cmd>J squash<cr>", desc = "Squash", mode = "n" },
	{ "<leader>j/", "<cmd>J split<cr>", desc = "Split", mode = "n" },
	{ "<leader>jr", "<cmd>J rebase<cr>", desc = "Rebase", mode = "n" },
	{ "<leader>j<", "<cmd>J undo<cr>", desc = "Undo", mode = "n" },
	{ "<leader>j>", "<cmd>J redo<cr>", desc = "Redo", mode = "n" },
	{ "<leader>jc", "<cmd>J commit<cr>", desc = "Commit", mode = "n" },
	{ "<leader>jb", group = "Bookmark", mode = "n" },
	{ "<leader>jbc", "<cmd>J bookmark create<cr>", desc = "Create", mode = "n" },
	{ "<leader>jbd", "<cmd>J bookmark delete<cr>", desc = "Delete", mode = "n" },
	{ "<leader>jt", group = "Tag", mode = "n" },
	{ "<leader>jts", "<cmd>J tag set<cr>", desc = "Set", mode = "n" },
	{ "<leader>jtd", "<cmd>J tag delete<cr>", desc = "Delete", mode = "n" },
	{ "<leader>jtp", "<cmd>J tag push<cr>", desc = "Push", mode = "n" },

	-- Kalulu
	{ "<leader>R", group = "Rest", mode = "n" },
	{ "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad", mode = "n" },
	{ "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", mode = "n" },
	{ "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", mode = "n" },
	{ "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment", mode = "n" },
	{
		"<leader>Rg",
		"<cmd>lua require('kulala').download_graphql_schema()<cr>",
		desc = "Download GraphQL schema",
		mode = "n",
	},
	{ "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", mode = "n" },
	{ "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", mode = "n" },
	{ "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", mode = "n" },
	{ "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", mode = "n" },
	{ "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay last request", mode = "n" },
	{ "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", mode = "n" },
	{ "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", mode = "n" },
	{ "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", mode = "n" },

	-- Spectre
	{ "<leader>S", group = "Spectre" },
	{ "<leader>St", "<cmd>lua require('spectre').toggle()<cr>", desc = "Toggle Spectre" },
	{
		"<leader>Sw",
		"<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
		desc = "Replace word under cursor (project)",
	},
	{
		"<leader>Sp",
		"<cmd>lua require('spectre').open_file({select_word=true})<cr>",
		desc = "Replace word under cursor (file)",
	},

	-- Rustacean
	{ "<leader>a", group = "Rust", mode = "n" },
	{ "<leader>aE", "<cmd>RustLsp expandMacro<cr>", desc = "Expand macro", mode = "n" },
	{ "<leader>ac", "<cmd>RustLsp openCargo<cr>", desc = "Open Cargo.toml", mode = "n" },
	{ "<leader>ap", "<cmd>RustLsp parentModule<cr>", desc = "Go to parent module", mode = "n" },
	{ "<leader>ad", "<cmd>RustLsp renderDiagnostic<cr>", desc = "Render diagnostic", mode = "n" },
	{ "<leader>ae", "<cmd>RustLsp explainError<cr>", desc = "Explain error", mode = "n" },
	{ "<leader>ar", "<cmd>RustLsp runnables<cr>", desc = "Runnables", mode = "n" },
	{ "<leader>aR", "<cmd>RustLsp debuggables<cr>", desc = "Debuggables", mode = "n" },
	{ "<leader>at", "<cmd>RustLsp testables<cr>", desc = "Testables", mode = "n" },
	{ "<leader>am", "<cmd>RustLsp moveItem up<cr>", desc = "Move item up", mode = "n" },
	{ "<leader>an", "<cmd>RustLsp moveItem down<cr>", desc = "Move item down", mode = "n" },
	{ "<leader>aj", "<cmd>RustLsp joinLines<cr>", desc = "Join lines (smart)", mode = "n" },
	{ "<leader>aa", "<cmd>RustLsp codeAction<cr>", desc = "Code action (rust)", mode = "n" },
	{ "<leader>ah", "<cmd>RustLsp hover actions<cr>", desc = "Hover actions", mode = "n" }, -- Rustecean

	-- Tips
	{ "<leader>i", group = "Tips", mode = "n" },
	{ "<leader>io", ":NeovimTips<CR>", desc = "Neovim tips", silent = true },
	{ "<leader>ib", ":NeovimTipsBookmarks<CR>", desc = "Bookmarked tips", silent = true },
	{ "<leader>ie", ":NeovimTipsEdit<CR>", desc = "Edit your Neovim tips", silent = true },
	{ "<leader>ia", ":NeovimTipsAdd<CR>", desc = "Add your Neovim tip", silent = true },
	{ "<leader>ih", ":help neovim-tips<CR>", desc = "Neovim tips help", silent = true },
	{ "<leader>ir", ":NeovimTipsRandom<CR>", desc = "Show random tip", silent = true },
	{ "<leader>ip", ":NeovimTipsPdf<CR>", desc = "Open Neovim tips PDF", silent = true },
})
