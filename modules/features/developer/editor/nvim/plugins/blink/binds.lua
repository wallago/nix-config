local function scroll(keys)
	return function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>" .. keys, true, false, true), "n", false)
		return true
	end
end

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<C-i>"] = { "select_prev", scroll("<C-u>") },
		["<C-n>"] = { "select_next", scroll("<C-d>") },
		["<C-p>"] = {}, -- free it up (falls back to builtin keyword completion)
	},
})
