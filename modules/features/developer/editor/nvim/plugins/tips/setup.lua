require("neovim_tips").setup({
	user_file = vim.fn.expand("~/sync-nvim/neovim_tips/user_tips.md"),
	user_tip_prefix = "[User] ", -- Prefix for user tips
	warn_on_conflicts = true, -- Warn about title conflicts
	daily_tip = 2, -- Daily tip: 0=off, 1=once per day, 2=every startup
})
