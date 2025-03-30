require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		rust = { "rustfmt", lsp_format = "fallback" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		fish = { "fish_indent" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
	},
	format_on_save = {
		enabled = true,
		timeout_ms = 1000,
		lsp_format = "fallback",
		callback = function(bufnr)
			require("notify")("File formatted successfully: " .. result, "info")
		end,
	},
	notify_on_error = true,
	notify_no_formatters = true,
})
