-- spell/grammar checking for prose (incl. jj describe messages)
vim.filetype.add({ extension = { jjdescription = "gitcommit" } })
vim.lsp.config("harper_ls", {
	cmd = { "harper-ls", "--stdio" },
	filetypes = { "gitcommit", "markdown", "text" },
})
vim.lsp.enable("harper_ls")
